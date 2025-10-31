# Delete scripts after use! -RemoveItem `script` -force 
# Or, if just using file directory, delete from recycle bin as well!

# Force GP update after running! Invoke-GPUpdate -Force

## When you have time, may need to ensure scripts worked manually

### Change account passwords: (see below for navigating to AD users)
	- NOTE: changing the passwords of "zCCDC Scoring Users" WILL AFFECT SCORING. Rulebook implies there's a way we can tell the judges about the password changes, we're gonna try to figure this out. DO NOT CHANGE THESE PASSWORDS UNLESS YOU HAVE A PLAN FOR COMMUNICATING IT TO THE JUDGES.
	- furthermore, if we are changing these, there are 20+ scoring users. Use the pass.ps1 script to change all scoring user passwords in one go.
	- **Associated script:** `pass.ps1`, `krbt.ps1`
	- Right click the user
	- "Reset password"
	- *Be sure to change the password of the KRBTGT account* ***TWICE***

# Download scripts:
- In the lab environment, some sites, like Github, weren't resolving. Not sure if this will be the case in the actual competition. If it is the case:
	- Navigate to the hosts file, at `C:\Windows\System32\drivers\etc\hosts`
	- add the following records:
		- 140.82.114.4   github.com
		- 140.82.114.22 collector.github.com
		- may need render.collector.github.com as well
	- **those IPs may change/have changed. ping those domains to get the current ones**
		- (tab-separated btwn IP and github.com)
	- go to github.com and search our repo, or just type in github.com/scsu-cyber-competition-club/scsu_ccdc2023-2024_public/tree/main
		- underscore between 2024 and public ^
	- or https://tinyurl.com/37f85fbn
	- download files manually
- otherwise, simply:
	- open PowerShell
	- curl -L -o repo.zip https://github.com/SCSU-Cyber-Competition-Club/SCSU_CCDC2023-2024_PUBLIC/archive/refs/heads/main.zip 
	- **UNDERSCORE AFTER 2024 ^**
	- or https://tinyurl.com/37f85fbn
	- use file manager to unzip folder, make a copy of what you need, then **delete anything else. delete from recycle bin as well** 

## Enabling script use:
- `Associated script: unblock.ps1`
- `unblock-file <script>`
- Do this manually for `unblock.ps1`, then run it to unblock the others

## Master script
master script shouldn't execute:
- unblock
	- will need to be run first anyhow
-dnssec
	-user input; lots of output
-honey
	-recycled
-whack
	-one-time, reactive use

## flush DNS
- ipconfig /flushdns
# Antivirus
- Start menu -> Virus & Threat Protection
- Ensure real-time protection turned **On**
- Check for updates
- **Run scans periodically**
- **virus scans trigger honeypot**

## Services to block
**Associated script:** `services.ps1`
see script
## Local firewall rules
- `Associated script: firewall2.ps1`
- Turning firewall on:
	- left hand side, right click Windows Defender Firewall with.... tab
	- Properties
	- set Firewall State to On


# Updates
- Start menu -> Check for updates
- Check for/install any **security** updates. Don't waste time with non-sec.
- ### Applying requires restart!

# Account Hardening
- Server Manager
- Top right Tools tab/Active Directory Users and Computers
- ### Delete unneeded accounts:
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

## Force Kerb (instead of NTLM/v2)
- audit:  Network Security: Restrict NTLM: Audit incoming NTLM traffic"
- force: Network Security: Restrict NTLM: Incoming NTLM Traffic: Deny all accounts
- ### Kerberos (password) encryption:
	- `Computer Config -> Policies -> Windows Settings -> Security settings -> Local policies -> Security Options -> Network security: Configure encryption types allowed for Kerberos`
	- Ensure **only** AES256 is enabled

- ### Counter LLMNR poisoning:
	- **Associated script:** `vaccine.ps1`
	- Back up to beginning of path in the GPO
	- **Computer Configuration -> Policies -> Administrative Templates -> Network -> DNS Client
	- Turn off multicast name resolution

- ### Counter PrintNightmare:
	- associated script: `services.ps1`
	- `Computer configuration/Administrative Templates/Printers`
	- Disable "Allow Print Spooler to accept client connections"
	


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
- **Associated script:** `EPA.ps1`
- ---**only bother if we can't disable ntlmv2**---, **otherwise skip this**
- Start menu -> Registry Editor
- **HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\LSA**
- to be enabled, **SuppressExtendedProtection** and **LmCompatibilityLevel** should be present. if not:
- Top left, click Edit/New/DWORD value/type `SuppressExtendedProtection`
- same for `LmCompatabilityLevel`
- then, for each:
	- Right click/Modify
	- Value 0 for Suppress, Value 5 for LmComp


# Harden SMB

### DO NOT DO THIS BEFORE OTHER WINDOWS USERS DO THIS. THEY SHOULD DO THIS AT THE SAME TIME AS YOU. DOING THIS AS A SCRIPT WILL BE MUCH BETTER SO YOU CAN ALL DO EACH OF THE FOUR COMMANDS ALL AT ONCE 
- Force SMBv3:
	- `Associated script: smb.ps1`
	- Set-SmbServerConfiguration -EnableSMB1Protocol $false
	- Set-SmbServerConfiguration -EnableSMB2Protocol $true
- Enable SMB signing:
	- in the following paths, right click the pane, create two new DWords, name them `EnableSecuritySignature` and `RequireSecuritySignature`, set value to 1:
	- HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManWorkstation\Parameters
	- HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters
	- or, do thru Powershell, i.e.
`"HKLM\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" /v RequireSecuritySignature /t REG_DWORD /d 1 /f`



## enable all logging

`auditpol /set /category:* /success:enable /failure:enable`

### CVE-2020-1350
`reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DNS\Parameters" /v TcpReceivePacketSize /t REG_DWORD /d 65280 /f`

### Unencrypted password to 3rd party SMB servers
`Computer Configuration/Windows Settings/Security Settings/Local Policies/Security Options/Microsoft Network Client: Send unencrypted password to 3rd-party SMB Servers`
disable.

### Disable anon logon
`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa`
RestrictAnonymous to 1

### Blocking Win32 binaries from making netconns when they shouldn't
firewall rules by Program. they specified TCP.
- %systemroot%\system32\notepad.exe
other ones, **which we don't know enough about and should research to ensure this won't break shit if we want to utilize**:
- %systemroot%\system32\regsvr32.exe
- %systemroot%\system32\calc.exe
- %systemroot%\system32\mshta.exe
- %systemroot%\system32\wscript.exe
- %systemroot%\system32\cscript.exe
- %systemroot%\system32\runscripthelper.exe
- %systemroot%\system32\hh.exe



