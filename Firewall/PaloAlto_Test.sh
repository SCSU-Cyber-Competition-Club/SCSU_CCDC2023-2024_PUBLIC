#!/bin/env bash

# Set Palo Alto management IP address.
#echo "Please enter Palo Alto IP address."
#read PALO_ALTO_IP
PALO_ALTO_IP='10.0.0.3'

# Set Palo Alto management username.
#echo "Please enter Palo Alto username."
#read PALO_ALTO_USER
PALO_ALTO_USER='dust'

# Set Palo Alto management password.
#echo "Please enter Palo Alto password."
#read PALO_ALTO_PASS
PALO_ALTO_PASS='P@ssw0rd'

# Set Palo Alto version.
#echo "Please enter Palo Alto Version."
#read PALO_ALTO_VERSION
PALO_ALTO_VERSION='11.0'


# Curl command to get API_KEY
API_KEY=$(curl -s -k -X POST "https://$PALO_ALTO_IP/api/?type=keygen&user=$PALO_ALTO_USER&password=$PALO_ALTO_PASS" | grep -oP '(?<=<key>)(.*?)(?=</key>)')


# Begin Address object section
# Begin Address object section
# Begin Address object section

echo
echo
echo "Start of Address Objects"
echo
# Add address object - public_int
curl -k -X POST \
					"https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Objects/Addresses?location=vsys&vsys=vsys1&name=public_int1" \
					-H "X-PAN-KEY: $API_KEY" \
					-d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "public_int1",
            "@vsys":"vsys1",
            "description": "Public Interface",
            "ip-netmask":"172.20.241.254\/24"
        }
    ]
}'

echo
# Add address object - user_int
curl -k -X POST \
					"https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Objects/Addresses?location=vsys&vsys=vsys1&name=user_int1" \
					-H "X-PAN-KEY: $API_KEY" \
					-d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "user_int1",
            "@vsys":"vsys1",
            "description": "User Interface",
            "ip-netmask":"172.20.242.254\/24"
        }
    ]
}'

echo
# Add address object - Internal_int
curl -k -X POST \
					"https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Objects/Addresses?location=vsys&vsys=vsys1&name=Internal_int1" \
					-H "X-PAN-KEY: $API_KEY" \
					-d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "Internal_int1",
            "@vsys":"vsys1",
            "description": "User Interface",
            "ip-netmask":"172.20.240.254\/24"
        }
    ]
}'

echo
# Add address object - public_net
curl -k -X POST \
					"https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Objects/Addresses?location=vsys&vsys=vsys1&name=public_net1" \
					-H "X-PAN-KEY: $API_KEY" \
					-d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "public_net1",
            "@vsys":"vsys1",
            "description": "Public Interface",
            "ip-netmask":"172.20.241.0\/24"
        }
    ]
}'

echo
# Add address object - user_net
curl -k -X POST \
					"https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Objects/Addresses?location=vsys&vsys=vsys1&name=user_net1" \
					-H "X-PAN-KEY: $API_KEY" \
					-d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "user_net1",
            "@vsys":"vsys1",
            "description": "User Interface",
            "ip-netmask":"172.20.242.0\/24"
        }
    ]
}'

echo
# Add address object - Internal_net
curl -k -X POST \
					"https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Objects/Addresses?location=vsys&vsys=vsys1&name=Internal_net1" \
					-H "X-PAN-KEY: $API_KEY" \
					-d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "Internal_net1",
            "@vsys":"vsys1",
            "description": "User Interface",
            "ip-netmask":"172.20.240.0\/24"
        }
    ]
}'

echo
# Add address object - Docker-Remote
curl -k -X POST \
					"https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Objects/Addresses?location=vsys&vsys=vsys1&name=2019_docker1" \
					-H "X-PAN-KEY: $API_KEY" \
					-d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "2019_docker1",
            "@vsys":"vsys1",
            "description": "2019_DockerRemote",
            "ip-netmask":"172.20.240.10\/24"
        }
    ]
}'

echo
# Add address object - Debian DNS-NTP
curl -k -X POST \
					"https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Objects/Addresses?location=vsys&vsys=vsys1&name=debian1" \
					-H "X-PAN-KEY: $API_KEY" \
					-d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "debian1",
            "@vsys":"vsys1",
            "description": "Debian10_DNSNTP",
            "ip-netmask":"172.20.240.20\/24"
        }
    ]
}'

echo
# Add address object - Ubuntu 18 Web
curl -k -X POST \
					"https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Objects/Addresses?location=vsys&vsys=vsys1&name=ubuntu_web1" \
					-H "X-PAN-KEY: $API_KEY" \
					-d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "ubuntu_web1",
            "@vsys":"vsys1",
            "description": "Ubuntu18_Web",
            "ip-netmask":"172.20.242.10\/24"
        }
    ]
}'

echo
# Add address object - 2019 AD-DNS-DHCP
curl -k -X POST \
					"https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Objects/Addresses?location=vsys&vsys=vsys1&name=2019_ad1" \
					-H "X-PAN-KEY: $API_KEY" \
					-d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "2019_ad1",
            "@vsys":"vsys1",
            "description": "2019_AD_DNS_DHCP",
            "ip-netmask":"172.20.242.200\/24"
        }
    ]
}'

echo
# Add address object - Splunk
curl -k -X POST \
					"https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Objects/Addresses?location=vsys&vsys=vsys1&name=splunk1" \
					-H "X-PAN-KEY: $API_KEY" \
					-d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "splunk1",
            "@vsys":"vsys1",
            "description": "Splunk",
            "ip-netmask":"172.20.241.20\/24"
        }
    ]
}'

echo
# Add address object - CentOS 7 E-comm
curl -k -X POST \
					"https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Objects/Addresses?location=vsys&vsys=vsys1&name=centos_ecomm1" \
					-H "X-PAN-KEY: $API_KEY" \
					-d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "centos_ecomm1",
            "@vsys":"vsys1",
            "description": "CentOS7_Ecomm",
            "ip-netmask":"172.20.241.30\/24"
        }
    ]
}'

echo
# Add address object - Fedora 21 Webmail
curl -k -X POST \
					"https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Objects/Addresses?location=vsys&vsys=vsys1&name=fedora_webmail1" \
					-H "X-PAN-KEY: $API_KEY" \
					-d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "fedora_webmail1",
            "@vsys":"vsys1",
            "description": "Fedora21_Webmail",
            "ip-netmask":"172.20.241.40\/24"
        }
    ]
}'

echo
# Add address object - Palo Alto
curl -k -X POST \
					"https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Objects/Addresses?location=vsys&vsys=vsys1&name=palo_alto1" \
					-H "X-PAN-KEY: $API_KEY" \
					-d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "palo_alto1",
            "@vsys":"vsys1",
            "description": "Palo_Alto",
            "ip-netmask":"172.20.242.150\/24"
        }
    ]
}'

echo
# Add address object - Ubuntu Wkst
curl -k -X POST \
					"https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Objects/Addresses?location=vsys&vsys=vsys1&name=ubuntu_wkst1" \
					-H "X-PAN-KEY: $API_KEY" \
					-d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "ubuntu_wkst1",
            "@vsys":"vsys1",
            "description": "Ubuntu_Workstation",
            "ip-netmask":"172.20.242.20\/24"
        }
    ]
}'


# Begin Service object section
# Begin Service object section
# Begin Service object section

echo
echo
echo "Start of Service Objects"
echo
# Add service object - Splunk Forwarder
curl -k -X POST \
					"https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Objects/Services?location=vsys&vsys=vsys1&name=splunk_fwd" \
					-H "X-PAN-KEY: $API_KEY" \
					-d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "splunk_fwd",
            "@vsys":"vsys1",
            "protocol": {
            	"tcp": {
            	"port": "9000,9997"
            	}
            }
        }
    ]
}'

echo
# Add service object - Splunk Forwarder
curl -k -X POST \
					"https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Objects/Services?location=vsys&vsys=vsys1&name=splunk_fwd" \
					-H "X-PAN-KEY: $API_KEY" \
					-d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "splunk_fwd",
            "@vsys":"vsys1",
            "protocol": {
            	"tcp": {
            	"port": "9000,9997"
            	}
            }
        }
    ]
}'


# Begin Security rules section
# Begin Security rules section
# Begin Security rules section


# Source Zone - from
# Source Address - source
# Destination Zone - to
# Destination Address - destination
# Application - application
# Service - service
# action - action

echo
echo
echo "Start of Securtiy Rules"
echo

# to-External Section
echo "To-external Section"
echo

# Add security Rule docker-to-external
curl -k -X POST \
  "https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Policies/SecurityRules?location=vsys&vsys=vsys1&name=docker-to-external" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "docker-to-external",
            "@vsys": "vsys1",
            "action": "allow",
            "application": {
                "member": [
                    "web-browsing",
                    "ssl",
                    "ntp-base",
                    "dns-base",
                    "ping",
                    "icmp"
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "any"
                ]
            },
            "from": {
                "member": [
                    "Internal"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "2019_docker1"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "External"
                ]
            }
        }
    ]
}'

echo
# Add security Rule debian-to-external
curl -k -X POST \
  "https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Policies/SecurityRules?location=vsys&vsys=vsys1&name=debian-to-external" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "debian-to-external",
            "@vsys": "vsys1",
            "action": "allow",
            "application": {
                "member": [
                    "web-browsing",
                    "ssl",
                    "ntp-base",
                    "dns-base",
                    "ping",
                    "icmp"
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "any"
                ]
            },
            "from": {
                "member": [
                    "Internal"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "debian1"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "External"
                ]
            }
        }
    ]
}'

echo
# Add security Rule ubuntuweb-to-external
curl -k -X POST \
  "https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Policies/SecurityRules?location=vsys&vsys=vsys1&name=debian-to-external" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "ubuntuweb-to-external",
            "@vsys": "vsys1",
            "action": "allow",
            "application": {
                "member": [
                    "web-browsing",
                    "ssl",
                    "ntp-base",
                    "dns-base",
                    "ping",
                    "icmp"
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "any"
                ]
            },
            "from": {
                "member": [
                    "User"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "ubuntu_web1"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "External"
                ]
            }
        }
    ]
}'

echo
# Add security Rule 2019_ad-to-external
curl -k -X POST \
  "https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Policies/SecurityRules?location=vsys&vsys=vsys1&name=2019_ad-to-external" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "2019_ad-to-external",
            "@vsys": "vsys1",
            "action": "allow",
            "application": {
                "member": [
                    "web-browsing",
                    "ssl",
                    "ntp-base",
                    "dns-base",
                    "ping",
                    "icmp"
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "any"
                ]
            },
            "from": {
                "member": [
                    "User"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "2019_ad1"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "External"
                ]
            }
        }
    ]
}'

echo
# Add security Rule ubuntuwkst-to-external
curl -k -X POST \
  "https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Policies/SecurityRules?location=vsys&vsys=vsys1&name=ubuntuwkst-to-external" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "ubuntuwkst-to-external",
            "@vsys": "vsys1",
            "action": "allow",
            "application": {
                "member": [
                    "web-browsing",
                    "ssl",
                    "ntp-base",
                    "dns-base",
                    "ping",
                    "icmp"
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "any"
                ]
            },
            "from": {
                "member": [
                    "User"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "ubuntu_wkst1"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "External"
                ]
            }
        }
    ]
}'

echo
# Add security Rule splunk-to-external
curl -k -X POST \
  "https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Policies/SecurityRules?location=vsys&vsys=vsys1&name=splunk-to-external" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "splunk-to-external",
            "@vsys": "vsys1",
            "action": "allow",
            "application": {
                "member": [
                    "web-browsing",
                    "ssl",
                    "ntp-base",
                    "dns-base",
                    "splunk",
                    "ping",
                    "icmp"
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "any"
                ]
            },
            "from": {
                "member": [
                    "Public"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "splunk1"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "External"
                ]
            }
        }
    ]
}'

echo
# Add security Rule ecomm-to-external
curl -k -X POST \
  "https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Policies/SecurityRules?location=vsys&vsys=vsys1&name=ecomm-to-external" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "ecomm-to-external",
            "@vsys": "vsys1",
            "action": "allow",
            "application": {
                "member": [
                    "web-browsing",
                    "ssl",
                    "ntp-base",
                    "dns-base",
                    "ping",
                    "icmp"
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "any"
                ]
            },
            "from": {
                "member": [
                    "Public"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "centos_ecomm1"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "External"
                ]
            }
        }
    ]
}'

echo
# Add security Rule webmail-to-external
curl -k -X POST \
  "https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Policies/SecurityRules?location=vsys&vsys=vsys1&name=webmail-to-external" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "webmail-to-external",
            "@vsys": "vsys1",
            "action": "allow",
            "application": {
                "member": [
                    "web-browsing",
                    "ssl",
                    "ntp-base",
                    "dns-base",
                    "ping",
                    "icmp",
                    "pop3",
                    "imap",
                    "smtp-base"
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "any"
                ]
            },
            "from": {
                "member": [
                    "Public"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "fedora_webmail1"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "External"
                ]
            }
        }
    ]
}'

echo
echo
# External-to Section
echo "External-to Section"

echo
# Add security Rule external-to-docker
curl -k -X POST \
  "https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Policies/SecurityRules?location=vsys&vsys=vsys1&name=external-to-docker" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "external-to-docker",
            "@vsys": "vsys1",
            "action": "allow",
            "application": {
                "member": [
                    "ping",
                    "icmp"
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "2019_docker1"
                ]
            },
            "from": {
                "member": [
                    "External"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "any"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "Internal"
                ]
            }
        }
    ]
}'

echo
# Add security Rule external-to-debian
curl -k -X POST \
  "https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Policies/SecurityRules?location=vsys&vsys=vsys1&name=external-to-debian" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "external-to-debian",
            "@vsys": "vsys1",
            "action": "allow",
            "application": {
                "member": [
                    "ping",
                    "icmp",
                    "ntp-base",
                    "dns-base"                    
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "debian1"
                ]
            },
            "from": {
                "member": [
                    "External"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "any"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "Internal"
                ]
            }
        }
    ]
}'

echo
# Add security Rule external-to-ubuntuweb
curl -k -X POST \
  "https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Policies/SecurityRules?location=vsys&vsys=vsys1&name=external-to-ubuntuweb" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "external-to-ubuntuweb",
            "@vsys": "vsys1",
            "action": "allow",
            "application": {
                "member": [
                    "ping",
                    "icmp",
                    "dns-base",
                    "web-browsing",
                    "ssl"                    
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "ubuntu_web1"
                ]
            },
            "from": {
                "member": [
                    "External"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "any"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "User"
                ]
            }
        }
    ]
}'

echo
# Add security Rule external-to-2019_ad
curl -k -X POST \
  "https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Policies/SecurityRules?location=vsys&vsys=vsys1&name=external-to-2019_ad" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "external-to-2019_ad",
            "@vsys": "vsys1",
            "action": "allow",
            "application": {
                "member": [
                    "ping",
                    "icmp",
                    "dns-base"               
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "2019_ad1"
                ]
            },
            "from": {
                "member": [
                    "External"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "any"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "User"
                ]
            }
        }
    ]
}'

echo
# Add security Rule external-to-ubuntuwkst
curl -k -X POST \
  "https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Policies/SecurityRules?location=vsys&vsys=vsys1&name=external-to-ubuntuwkst" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "external-to-ubuntuwkst",
            "@vsys": "vsys1",
            "action": "allow",
            "application": {
                "member": [
                    "ping",
                    "icmp"            
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "ubuntu_wkst1"
                ]
            },
            "from": {
                "member": [
                    "External"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "any"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "User"
                ]
            }
        }
    ]
}'

echo
# Add security Rule external-to-splunk
curl -k -X POST \
  "https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Policies/SecurityRules?location=vsys&vsys=vsys1&name=external-to-splunk" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "external-to-splunk",
            "@vsys": "vsys1",
            "action": "allow",
            "application": {
                "member": [
                    "ping",
                    "icmp",
                    "splunk"
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "splunk1"
                ]
            },
            "from": {
                "member": [
                    "External"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "any"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "Public"
                ]
            }
        }
    ]
}'

echo
# Add security Rule external-to-ecomm
curl -k -X POST \
  "https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Policies/SecurityRules?location=vsys&vsys=vsys1&name=external-to-ecomm" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "external-to-ecomm",
            "@vsys": "vsys1",
            "action": "allow",
            "application": {
                "member": [
                    "ping",
                    "icmp",
                    "dns-base",
                    "web-browsing",
                    "ssl"
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "centos_ecomm1"
                ]
            },
            "from": {
                "member": [
                    "External"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "any"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "Public"
                ]
            }
        }
    ]
}'

echo
# Add security Rule external-to-webmail
curl -k -X POST \
  "https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Policies/SecurityRules?location=vsys&vsys=vsys1&name=external-to-webmail" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "external-to-webmail",
            "@vsys": "vsys1",
            "action": "allow",
            "application": {
                "member": [
                    "ping",
                    "icmp",
                    "dns-base",
                    "web-browsing",
                    "ssl",
                    "pop3",
                    "imap",
                    "smtp-base"
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "fedora_webmail1"
                ]
            },
            "from": {
                "member": [
                    "External"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "any"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "Public"
                ]
            }
        }
    ]
}'

echo
echo
# Interzone Section
echo "Interzone Section"

echo
# Add security Rule interzone
curl -k -X POST \
  "https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Policies/SecurityRules?location=vsys&vsys=vsys1&name=interzone" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "interzone",
            "@vsys": "vsys1",
            "action": "allow",
            "rule-type": "interzone",
            "application": {
                "member": [
                    "ping",
                    "icmp",
                    "dns-base",
                    "ldap",
                    "web-browsing",
                    "ssl",
                    "splunk"
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "any"
                ]
            },
            "from": {
                "member": [
                    "Internal",
                    "Public",
                    "User"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "any"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "Internal",
                    "Public",
                    "User"
                ]
            }
        }
    ]
}'

echo
echo
# Intrazone Section
echo "Intrazone Section"

echo
# Add security Rule intrazone
curl -k -X POST \
  "https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Policies/SecurityRules?location=vsys&vsys=vsys1&name=intrazone" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "intrazone",
            "@vsys": "vsys1",
            "action": "allow",
            "rule-type": "intrazone",
            "application": {
                "member": [
                    "ping",
                    "icmp",
                    "dns-base",
                    "ldap",
                    "web-browsing",
                    "ssl",
                    "splunk"
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "any"
                ]
            },
            "from": {
                "member": [
                    "Internal",
                    "Public",
                    "User"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "any"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "Internal",
                    "Public",
                    "User"
                ]
            }
        }
    ]
}'

echo
echo
# Drop-any Section
echo "Drop-any Section"

echo
# Add security Rule drop-any
curl -k -X POST \
  "https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Policies/SecurityRules?location=vsys&vsys=vsys1&name=drop-any" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "drop-any",
            "@vsys": "vsys1",
            "action": "drop",
            "application": {
                "member": [
                    "any"
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "any"
                ]
            },
            "from": {
                "member": [
                    "any"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "any"
                ]
            },
            "source": {
                "member": [
                    "any"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "any"
                ]
            }
        }
    ]
}'

echo
echo
# DoS Protection Security Profiles
echo "DoS Protection Security Profiles Section"

echo
# Add DoS Protection Security Profile
curl -k -X POST \
  "https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Objects/DoSProtectionSecurityProfiles?location=vsys&vsys=vsys1&name=BlockExcessiveConnections" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@name": "BlockExcessiveConnections",
            "@location": "vsys",
            "@vsys": "vsys1",
            "flood": {
                "tcp-syn": {
                "red": {
                    "alarm-rate": "50",
                    "activate-rate": "50",
                    "maximal-rate": "100"
                },
                "enable": "yes"
                },
                "udp": {
                "red": {
                    "maximal-rate": "100",
                    "alarm-rate": "50",
                    "activate-rate": "50"
                },
                "enable": "yes"
                },
                "icmp": {
                "red": {
                    "maximal-rate": "100",
                    "alarm-rate": "50",
                    "activate-rate": "50"
                },
                "enable": "yes"
                },
                "icmpv6": {
                "red": {
                    "maximal-rate": "100",
                    "alarm-rate": "50",
                    "activate-rate": "50"
                },
                "enable": "yes"
                },
                "other-ip": {
                "red": {
                    "maximal-rate": "100",
                    "alarm-rate": "50",
                    "activate-rate": "50"
                },
                "enable": "yes"
                }
            },
            "resource": {
                "sessions": {
                "enabled": "no"
                }
            },
            "type": "classified"
        }
    ]
}'

echo
echo
# DoS Protection Policy
echo "DoS Protection Policy Section"

echo
# Add DoS Protection Policy
curl -k -X POST \
  "https://$PALO_ALTO_IP/restapi/v$PALO_ALTO_VERSION/Policies/DoSRules?location=vsys&vsys=vsys1&name=BlockExcessiveConnections" \
  -H "X-PAN-KEY: $API_KEY" \
-d '{
    "entry": [
        {
            "@name": "BlockExcessiveConnections",
            "@location": "vsys",
            "@vsys": "vsys1",
            "from": {
                "zone": {
                "member": [
                    "External"
                ]
                }
            },
            "to": {
                "zone": {
                "member": [
                    "Internal",
                    "Public",
                    "User"
                ]
                }
            },
            "protection": {
                "classified": {
                "classification-criteria": {
                    "address": "source-ip-only"
                },
                "profile": "BlockExcessiveConnections"
                }
            },
            "source": {
                "member": [
                "any"
                ]
            },
            "destination": {
                "member": [
                "any"
                ]
            },
            "source-user": {
                "member": [
                "any"
                ]
            },
            "service": {
                "member": [
                "any"
                ]
            },
            "action": {
                "deny": {}
            }
        }
    ]
}'