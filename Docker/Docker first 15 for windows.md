1. **Change Password**
2. Refer to Windows Hardening Guide/Checklist(Carls, will upload too) and complete hardening the environment
3. ***Checklist for Basic Hardening of a Windows System:

1. **Update the Operating System:**
    
    - **Explanation:** Ensure that the Windows operating system is up-to-date with the latest security patches.
    - **How to:** Run Windows Update to download and install the latest updates.
2. **Install and Update Antivirus Software:**
    
    - **Explanation:** Install a reputable antivirus software and keep it updated.
    - **How to:** Download and install antivirus software, and regularly update its virus definitions.
3. **Enable Windows Firewall:**
    
    - **Explanation:** Turn on the built-in Windows Firewall to control incoming and outgoing network traffic.
    - **How to:** Go to Control Panel > System and Security > Windows Defender Firewall.
4. **Create Strong User Passwords:**
    
    - **Explanation:** Ensure all user accounts have strong, unique passwords.
    - **How to:** Go to Control Panel > Administrative Tools > Computer Management > Local Users and Groups.
5. **Disable Unnecessary Services:**
    
    - **Explanation:** Disable or set unnecessary services to manual or disabled.
    - **How to:** Use the `services.msc` console to manage services.
6. **Configure User Account Control (UAC):**
    
    - **Explanation:** Adjust UAC settings to prompt for administrator approval.
    - **How to:** Go to Control Panel > Security and Maintenance > Change User Account Control settings.
7. **Remove Unnecessary Software:**
    
    - **Explanation:** Uninstall unnecessary or unused software.
    - **How to:** Go to Control Panel > Programs > Programs and Features.
8. **Encrypt Sensitive Data:**
    
    - **Explanation:** Use BitLocker or another encryption tool to encrypt sensitive data.
    - **How to:** Access BitLocker settings via Control Panel or Settings.
9. **Regularly Backup Data:**
    
    - **Explanation:** Set up regular backups of important data.
    - **How to:** Use built-in Backup and Restore or a third-party backup tool.
10. **Audit and Monitor System Logs:**
    
    - **Explanation:** Regularly check system logs for suspicious activities.
    - **How to:** Use the Event Viewer to review logs.
11. **Secure Remote Desktop Access:**
    
    - **Explanation:** If applicable, secure Remote Desktop settings.
    - **How to:** Adjust Remote Desktop settings in System Properties.
	    Disable SMBV1: Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol

**DOCKER STUFF**
=
-Docker is outdated by default, here is how to fix it
- Go to hyper-v manager in start
- Ubuntu_VM is where docker will actually be run, but you need to force turn it off, open powershell and run this command:
``` Stop-VM -Name Ubuntu_VM -TurnOff -Force```
- Run ubuntu, immediately you run it press shift and esc in the vm to go into bios mode
- Select recovery and boot into recovery mode
- Select root
- in the root terminal that opens, add user using ```sudo adduser USERNAME```and give it the credentials you want
- reboot the system
- you have docker!

 1. Check Docker website for update, if there is update docker, make sure to `Stop-Service Docker`

 2. Check images using `docker images`. Use `docker rmi "image-name" -f` to remove any unnecessary images.
 3. Check running containers using `docker ps -a`. Use `docker stop "container-id"` to stop any unnecessary containers.

4.  **Restrict Docker command access:**
    
    a. Open the Group Policy Management Console (GPMC).
    
    b. Navigate to Computer Configuration > Policies > Windows Settings > Security Settings > AppLocker > Application Execution Policies > Enforcement Policies.
    
    c. Create a new AppLocker rule that denies execution of Docker commands from non-administrator users. For example, to deny execution of the "docker" command, create a rule with the following settings:
    
    - Rule name: Deny Docker for non-admins
    - Rule type: File system
    - Enforcement: Audit only
    - Path: docker.exe
    - Apply to: Current user
    - User: Except local administrators
    
    d. Change the enforcement to "Enforce" to block execution of Docker commands for non-administrators.
5. Constantly check event viewer for logs, Set up a splunk forwarder to forward logs to splunk team. Also have wireshark running to inspect packets for any malicious packets


6. DISABLE SSH

-  **Locate your `sshd_config` file:**
    
    - The configuration file for OpenSSH on Windows is typically located in the installation directory. It could be something like `C:\ProgramData\ssh\sshd_config`.
- **Edit the `sshd_config` file:**
    
    - Open the `sshd_config` file in a text editor with administrative privileges (e.g., Notepad as Administrator).
- **Find the `PermitRootLogin` directive:**
    
    - Look for a line that says `PermitRootLogin` in the `sshd_config` file.
- **Set `PermitRootLogin` to `no`:**
    
    - Change the value of `PermitRootLogin` to `no`. If the line is commented out (starts with `#`), uncomment it.
    
    Example:
    
    configCopy code
    
    `PermitRootLogin no`
    
- **Save the file:**
    
    - Save the changes to the `sshd_config` file.
- **Restart the SSH server:**
    
    - Restart the SSH server service to apply the changes.
    
    You can do this through the Services panel or by running the following command in PowerShell as Administrator:
    `Restart-Service sshd`

***WINDOWS SERVER BACKUP***
=
- Install windows server backup using this command:
  ``` Install-WindowsFeature Windows-Server-Backup```
  - Run windows server backup and backup the system image for use later
  DISABLE SMBV1: 
```Set-SmbServerConfiguration -EnableSMB1Protocol $false```   
