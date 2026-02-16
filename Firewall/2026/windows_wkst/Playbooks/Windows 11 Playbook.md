### Delete scripts after use! -RemoveItem `script` -force 
### Or, if just using file directory, delete from recycle bin as well!

### When you have time, may need to ensure scripts worked manually

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
	- curl -o repo.zip https://github.com/SCSU-Cyber-Competition-Club/SCSU_CCDC2023-2024_PUBLIC/archive/refs/heads/main.zip 
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



## Disallowing remote connections
don't really see a powershell equivalent
`Control Panel -> System and Security -> System -> Remote Desktop`




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



