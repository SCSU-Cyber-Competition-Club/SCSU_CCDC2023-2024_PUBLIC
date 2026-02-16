# !!! Commit Early Commit Often !!!
## Connect to Palo Alto
`https://172.20.242.150`
	User: admin
	Pass: Changeme123
### Change User Passwords
Palo Alto > Device > Administrators >
	Administrator - Not Used - Change Password
	Admin - Used - Change Password

## Updating Palo Alto
Palo Alto > Device > Software >
	Update Software is disabled in the environment.
Palo Alto > Device > Dynamic Updates
	Download and install latest "Application and Threats" Update.

## DHCP Server (optional)
Palo Alto > Network > DHCP >
	Configure/modify any needed DHCP scopes.

### Disable Extra Management Interface Option
Palo Alto > Device > Setup > Interfaces > Management > 
![[Pasted image 20250120195650.png]]
Remove SSH, HTTP, Telnet, SNMP
Set Permitted IP Addresses to ubuntu wkst only. 
Since that is a DHCP set for the range it could be for Ubuntu wkst, e.x. 172.20.242/24
Alternatively set 172.20.242.101 as static IP for ubuntu wkst and only allow that. (Preferred)


# !!! Commit Early Commit Often !!!
## Add Services
Palo Alto > Objects > Services >
	service-DNS-UDP
		Port: UDP 53
	service-DNS-TCP
		Port: TCP 53
	service-NTP
		Port: UDP 123
	service-http
		Port: TCP 80, 8080
	service-https
		Port: TCP 443
	service-SPLUNK-MGT
		Port: TCP 8000
	service-SPLUNK-FWD
		Port: TCP 9000
	service-Webmail
		Port: TCP 110, 995, 143, 993, 25, 465
	service-AD-TCP
		Port: TCP  88, 389, 636
	service-AD-UDP
		Port: UDP 389, 88
	service-DHCP
		Port: UDP 67, 68

## Add Addresses
Palo Alto > Objects > Addresses >
	**Google-DNS**
		IP: 8.8.8.8
	**Internal**
		IP: 172.20.240.0/24
			**Docker**
				IP: 172.20.240.10
			**Debian**
				IP: 172.20.240.20
	**Public**
		IP: 172.20.241.0/24
			**Splunk**
				IP: 172.20.241.20
			**Ecomm**
				IP: 172.20.241.30
			**Webmail**
				IP: 172.20.241.40
	**User**
		IP: 172.20.242.0/24
			**Ubuntu Web**
				IP: 172.20.242.10
			**AD**
				IP: 172.20.242.200
			**Ubuntu Wkst**
				IP: 172.20.242.101


# !!! Commit Early Commit Often !!!

## Create Policies
Palo Alto > Policies > Security
*Remember policy apply order top first.*

In competition prioritize the following rules in the below tiers.
**Tier1:**
1, 1a, 2, 3, 4, 5,6
**Tier2:**
5a (Modify 5), 4a, 4b, 4c (Remove 4)
**Tier3:**
2a (Modify 2), 7

### 1. Remote-DROP
	Type
		Universal
	Source
		Any
	Destination
		Any
	Application
		Any
	Service
		service-remote
	Action
		Drop

### 1a. ICMP-ALLOW
	Type
		Universal
	Source
		Any
	Destination
		Any
	Application
		icmp
		ping
	Service
		application-default
	Action
		Allow
### 2. External2Any-ALLOW (Temp)
	Type
		Universal
	Source
		Any
	Destination
		Any
	Application
		Any
	Service
		service-DNS-UDP
		serivce-http
		service-https
		service-NTP
		service-SPLUNK-MGT
		service-Webmail
		service-AD (Might be needed depneds on scoring)
	Action
		Allow

### 2a. External2Any-ALLOW (Final)
	Type
		Universal
	Source
		Zone: External
	Destination
		Zone: Internal, Public, User
	Application
		Any
	Service
		service-DNS-UDP
		serivce-http
		service-https
		service-NTP
		service-SPLUNK-MGT
		service-Webmail
		service-AD (Might be needed depneds on scoring)
	Action
		Allow

### 3. External2Any-DROP
	Type
		Universal
	Source
		External
	Destination
		Zone: Internal, Public, User
	Application
		Any
	Service
		Any
	Action
		Drop


## 4. Interzone-Allow (Temp)
	Type
		Interzone
	Source
		Zone: Internal, Public, User
	Destination
		Zone: Internal, Public, User
	Application
		Any
	Service
		Any
	Action
		Allow

## 4a. Internal-Allow (Final)
	Type
		Interzone
	Source
		Zone: Public, User
	Destination
		Zone: Internal
	Application
		Any
	Service
		service-DNS-UDP
		service-DNS-TCP
		service-NTP
		service-http
		service-https
		service-SPLUNK-MGT
		service-SPLUNK-FWD
	Action
		Allow

## 4b. Public-Allow (Final)
	Type
		Interzone
	Source
		Zone: Internal, User
	Destination
		Zone: Public
	Application
		Any
	Service
		service-DNS-UDP
		service-NTP
		service-http
		service-https
		service-SPLUNK-MGT
		service-SPLUNK-FWD
		service-AD-TCP
		service-AD_UDP
	Action
		Allow

## 4c. User-Allow (Final)
	Type
		Interzone
	Source
		Zone: Internal, Public
	Destination
		Zone: User
	Application
		Any
	Service
		service-DNS-TCP
		service-DNS-UDP
		service-AD-TCP
		service-AD_UDP
		service-NTP
		service-http
		service-https
		service-SPLUNK-FWD
		
	Action
		Allow

## 5. Intrazone-Allow (Temp)
	Type
		Intrazone
	Source
		Zone: Internal, Public, User
	Destination
		Intrazone
	Application
		Any
	Service
		Any
	Action
		Allow


## 5a. Intrazone-Allow (Final)
	Type
		Intrazone
	Source
		Zone: Internal, Public, User
	Destination
		Intrazone
	Application
		Any
	Service
		service-DNS-TCP
		service-DNS-UDP
		service-AD-TCP
		service-AD_UDP
		service-SPLUNK-MGT
		service-SPLUNK-FWD
		serivce-https
		service-http
		service-DHCP
		service-NTP
	Action
		Allow

## 6. ToExternal-Allow
	Type
		Universal
	Source
		Address: Internal, Public, User
	Destination
		Any
	Application
		Any
	Service
		service-SPLUNK-FWD
		serivce-https
		service-http
		service-DHCP
		service-DNS
		service-NTP
		service-Webmail
		service-AD (Maybe if scoring needed)
	Action
		Allow


## 7. Implicit-Drop (Last Rule)
	Type
		Universal
	Source
		Any
	Destination
		Any
	Application
		Any
	Service
		any
	Action
		Drop


# !!! Commit Early Commit Often !!!

## DDOS Protection
Palo Alto > Objects > Security Rules > DoS Protection >

Create a New DoS Protection Profile.
Name : DoS
Type: Classified
Choose each of the flood protection types
- SYN Flood
- UDP Flood
- ICMP Flood
- ICMPv6 Flood
- Other IP Flood
- 
Change the connection rate to trigger on a thousands value.
![[Pasted image 20250122203249.png]]

Monitoring Rules
https://knowledgebase.paloaltonetworks.com/KCSArticleDetail?id=kA10g000000ClSlCAK

