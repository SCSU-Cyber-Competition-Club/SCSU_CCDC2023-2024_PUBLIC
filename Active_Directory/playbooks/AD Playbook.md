# Delete scripts after use! -RemoveItem `script` -force

# Force GP update after running! Invoke-GPUpdate -Force

## When you have time, may need to ensure scripts worked manually (especially vaccine)
# Download scripts:
- In the lab environment, some sites, like Github, weren't resolving. Not sure if this will be the case in the actual competition. If it is the case:
	- Navigate to the hosts file, at `C:\Windows\System32\drivers\etc\hosts`
	- add the following record: 140.82.116.4   github.com 
		- (tab-separated btwn IP and github.com)
	- go to github.com and search our repo, or just type in github.com/scsu-cyber-competition-club/scsu_ccdc2023-2024_public/tree/main
		- underscore between 2024 and public ^
	- download files manually
- otherwise, simply:
	- open PowerShell
	- curl -o repo.zip https://github.com/SCSU-Cyber-Competition-Club/SCSU_CCDC2023-2024_PUBLIC/archive/refs/heads/main.zip 
	- **UNDERSCORE AFTER 2024 ^**
	- use file manager to unzip folder, make a copy of what you need, then **delete anything else. delete from recycle bin as well** 

## Enabling script use:
- `Associated script: unblock.ps1`
- `unblock-file <script>`
- Do this manually for `unblock.ps1`, then run it to unblock the others
# Antivirus
- Start menu -> Virus & Threat Protection
- Ensure real-time protection turned **On**
- Check for updates
- Run a quick scan
- **Run scans periodically**

## Local firewall rules
- `Associated script: firewall.ps1`
- Start menu -> `Windows Defender Firewall`
- `Advanced features`


# Updates
- Start menu -> Check for updates
- Check for/install any **security** updates. Don't waste time with non-sec.


### Change account passwords: (see below for navigating to AD users)
	- NOTE: changing the passwords of "zCCDC Scoring Users" WILL AFFECT SCORING. Rulebook implies there's a way we can tell the judges about the password changes, we're gonna try to figure this out. DO NOT CHANGE THESE PASSWORDS UNLESS YOU HAVE A PLAN FOR COMMUNICATING IT TO THE JUDGES.
	- furthermore, if we are changing these, there are 20+ scoring users. Use the pass.ps1 script to change all scoring user passwords in one go.
	- **Associated script:** `pass.ps1`, `krbt.ps1`
	- Right click the user
	- "Reset password"
	- *Be sure to change the password of the KRBTGT account* ***TWICE***


### Change ASMAIL1 A record IP to NAT
- Server Manager -> DNS
- Forward Lookup Zones
- Right click ASMAIL1, Properties:
- IP Address to `172.25.21.39`
# Account Hardening
- Server Manager
- Top right Tools tab/Active Directory Users and Computers
- ### Delete unneeded accounts:
	- **Associated script:** `account_cull.ps1`
	- Right click the user
	- "Delete"
- Right click user
- "Properties"
- ### Force Kerberos preauth:
	- **Associated script:** `preauth.ps1`
	- Account tab
	- Disable "Do not require Kerberos preauthorization"
- ### User remote control (don't spend too much time, "Disallowing remote connections" step below should be enough):
	- Properties -> Remote Control tab

## Disallowing remote connections
don't really see a powershell equivalent
`Control Panel -> System and Security -> System -> Remote Desktop`
# Modify Group Policy
-  Server Manager
- Top right Tools tab/Group Policy Management
- Under Domains, find the Group Policy Object to edit (Likely called `Default Domain Policy`)
- Right click/Edit


### First:
- enforce Default Domain Policy, disable all others
- ### Lockout policy:
	- Back up from Password Policy, click on Account Lockout Policies
	- Define all properties:
		- Account Lockout Duration - recommended 15-60 minutes
		- Account Lockout Threshold - recommended 3-5 attempts
		- Allow Admin Account Lockout - must **Enable**
		- Reset account lockout counter after - recommended 15-60 minutes

- ### Kerberos (password) encryption:
	- `Computer Config -> Policies -> Windows Settings -> Security settings -> Local policies -> Security Options -> Network security: Configure encryption types allowed for Kerberos`
	- Ensure **only** AES256 is enabled

- ### Counter LLMNR poisoning:
	- **Associated script:** `vaccine.ps1`
	- Back up to beginning of path in the GPO
	- **Computer Configuration -> Policies -> Administrative Templates -> Network -> DNS Client
	- Turn off multicast name resolution

- ### Counter PrintNightmare:
	- `Computer configuration/Administrative Templates/Printers`
	- Disable "Allow Print Spooler to accept client connections"
	
- 

- ### protecting IP traffic by requiring Kerberos:
	- `Computer Configuration -> Windows Settings -> Security Settings -> IP Security Policies`
	- Enable `Secure Server...`
	
# Counter NBT-NS poisoning
- #### This will require a system restart!
- **Associated script:** `vaccine.ps1`
- Open Control Panel
- Network Sharing Center
- Change adapter settings
- right click the network adapter
- "Properties"
- click IPv4 Properties **(click on the text, not the checkbox)**
- click Advanced
- WINS tab
- Check the box for "Disable NetBIOS over TCP/IP"

# Force NTLMv2 with EPA:
-**NOTE: I'm pretty sure this isn't necessary if you're enforcing Kebereros (see above), though it may be if there's legacy systems that can't use Kerberos...**
(unlikely, but possible, so leaving this in here just in case)
- **Associated script:** `EPA.ps1`
- Start menu -> Registry Editor
- **HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\LSA**
- to be enabled, **SuppressExtendedProtection** and **LmCompatibilityLevel** should be present. if not:
- Top left, click Edit/New/DWORD value/type `SuppressExtendedProtection`
- same for `LmCompatabilityLevel`
- then, for each:
	- Right click/Modify
	- Value 0 for Suppress, Value 5 for LmComp

# SMB Hardening:
- **Associated script:** `smb.ps1`
- **Oops. looks like I left in a methodology for this that is completely wrong, and hallucinated by ChatGPT. See the smb.ps1 script for how to do this properly**
- (it's more complicated than it should be. Unlike SMB1 and SMB2, there is NOT an -EnableSmb3Protocol powershell command)





## Services to block
**Associated script:** `services.ps1`
**(NOTE: this last might be missing a couple of updates. Services.ps1 has fully updated list)**
Search bar, services:
- Remote Access Auto Connection Manager
- Remote Access Connection Manager
- Remote Desktop Configuration
- Remote Desktop Services
- Remote Desktop Services UserMode Port Redirector
- Remote Procedure Call (RPC) Locator
- Remote Registry
- Routing and Remote Access
- **spoolsv**
- ### Do not stop Rpcss and Winmgmt!
	- while these services (RPC and WMI) are dangerous remote management services, RPC is integral to Windows, and WMI is needed as a domain controller


