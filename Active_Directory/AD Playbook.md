# Delete scripts after use! -RemoveItem `script`

# Download scripts:
- Invoke-WebRequest https://github.com/SCSU-Cyber-Competition-Club/SCSU_CCDC2023-2024_PUBLIC/archive/refs/heads/main.zip -OutFile scripts.zip
- Expand-Archive -Path `PathToTheZIPFile` -DestinationPath `PathToCurrentDirectory` -Force
- Copy-Item -path ./SCSU_CCDC2023-2024_public-main\active_directory\scripts -Destination `PathToCurrentDirectory` -Recurse
- Remove-Item `zip file`
- Remove-Item `expanded repo file`

### Change account passwords: (see below for navigating to AD users)
	- **Associated script:** `checklist.ps1`, `krbt.ps1`
	- Right click the user
	- "Reset password"
	- *Be sure to change the password of the KRBTGT account* ***TWICE***

# Antivirus
- Start menu -> Virus & Threat Protection
- Ensure real-time protection turned **On**
- Check for updates
- Run a quick scan

# Updates
- Start menu -> Check for updates
- Check for/install any **security** updates. Don't waste time with non-sec.


# Account Hardening
- Server Manager
- Top right Tools tab/Active Directory Users and Computers
- ### Delete unneeded accounts:
	- **Associated script:** `account_cull.ps1`
	- Right click the user
	- "Delete"
- Right click user
- "Properties"
- ### Disable Account SPNs:
	- **Associated script:** `SPNumerate.ps1`
	- Attribute Editor tab
	- ServicePrincipleName attribute (Disable this)
- ### Force Kerberos preauth:
	- **Associated script:** `preauth.ps1`
	- Account tab
	- Disable "Do not require Kerberos preauthorization"
- ### Disable unrestricted Kerberos delegation:
	- **Associated script:** `delegation.ps1`
	-  Back up from the Users tab, and go to the Computers tab
	- Right click computer
	- "Properties"
	- Delegation tab
	- Check the box for "Do not trust this computer for delegation"


# Modify Group Policy
-  Server Manager
- Top right Tools tab/Group Policy Management
- Under Domains, find the Group Policy Object to edit (Likely called `Default Domain Policy`)
- Right click/Edit
## Harden password policy:
**Associated script:** `passwordGPO.ps1`
- **Computer Configuration** > **Policies** > **Windows Settings** > **Security Settings** > **Account Policies** > **Password Policy**
- You should set:
	- Minimum password length to 8
	- Enforce password complexity requirements to Enabled
	- Store passwords using reversible encryption to Disabled

- ### Lockout policy:
	- **Associated script:** `passGPO.ps1`
	- Back up from Password Policy, click on Account Lockout Policies
	- Define all properties:
		- Account Lockout Duration - recommended 15-60 minutes
		- Account Lockout Threshold - recommended 3-5 attempts
		- Allow Admin Account Lockout - must **Enable**
		- Reset account lockout counter after - recommended 15-60 minutes

- ### Counter LLMNR poisoning:
	- **Associated script:** `vaccine.ps1`
	- Back up to beginning of path in the GPO
	- **Computer Configuration -> Policies -> Administrative Templates -> Network -> DNS Client
	- Turn off multicast name resolution
	
- ### Force Kerberos signing:
	- **Associated script:** `kerbsign.ps1`
	- Back up in the GPO path to Administrative Templates
	- **System** > **KDC (Key Distribution Center)**
	- enable **Require strong (Windows 2000 or later) authentication for all clients**.

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
- Just use PowerShell for this...
- Start menu -> Powershell -> Right click -> **Run as administrator**
- Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force
- Set-SmbServerConfiguration -EnableSMB2Protocol $false -Force
- If SMB is required, keep SMBv3 and enable SMB signing in GPO:
	- Computer Configuration > Administrative Templates > Network > Lanman Workstation > Enable "Enable security feature"
	- Computer Configuration > Administrative Templates > Network > Lanman Server > Enable "Require security signature"
- if SMB not required, disable SMBv3 as well:
	- Set-SmbServerConfiguration -EnableSMB3Protocol $false -Force

## Set up firewall rules for any remote services
- This will be fleshed out in the future, for now, just use windows firewall gui
- 3389 RPD
- 445 SMB (need?)
- 135 WMI
