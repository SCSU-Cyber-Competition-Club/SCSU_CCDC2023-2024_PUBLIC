1. **Check Windows Version:**
    
    - **Command:** `ver`
    - **Example:** `ver`
2. **Check Network Configuration:**
    
    - **Command:** `ipconfig /all`
    - **Example:** `ipconfig /all`
3. **List Running Processes:**
    
    - **Command:** `tasklist`
    - **Example:** `tasklist`
4. **Terminate a Process:**
    
    - **Command:** `taskkill /F /IM process_name.exe`
    - **Example:** `taskkill /F /IM notepad.exe`
5. **Check Active Network Connections:**
    
    - **Command:** `netstat -ano`
    - **Example:** `netstat -ano`
6. **Check System Information:**
    
    - **Command:** `systeminfo`
    - **Example:** `systeminfo`
7. **Check for Disk Errors:**
    
    - **Command:** `chkdsk C: /f`
    - **Example:** `chkdsk C: /f`
8. **Check and Repair System Files:**
    
    - **Command:** `sfc /scannow`
    - **Example:** `sfc /scannow`
9. **Check System File Permissions:**
    
    - **Command:** `icacls C:\Windows\System32\file.dll`
    - **Example:** `icacls C:\Windows\System32\kernel32.dll`
10. **Check for Open Ports:**
    
    - **Command:** `netstat -an`
    - **Example:** `netstat -an`
11. **Check and Repair Disk Permissions:**
    
    - **Command:** `secedit /configure /cfg %windir%\inf\defltbase.inf /db defltbase.sdb /verbose`
    - **Example:** `secedit /configure /cfg %windir%\inf\defltbase.inf /db defltbase.sdb /verbose`
12. **Check User Permissions:**
    
    - **Command:** `whoami`
    - **Example:** `whoami`
13. **Check for Suspicious Files:**
    
    - **Command:** `dir C:\ /s /b | findstr .exe`
    - **Example:** `dir C:\ /s /b | findstr .exe`
14. **Check for Listening Ports:**
    
    - **Command:** `netstat -an | find "LISTENING"`
    - **Example:** `netstat -an | find "LISTENING"`
15. **Check Firewall Configuration:**
    
    - **Command:** `netsh advfirewall show allprofiles`
    - **Example:** `netsh advfirewall show allprofiles`

### Security Hardening Checklist for Linux System:

1. **Check System Logs:**
    
    - **Command:** `cat /var/log/syslog`
    - **Example:** `cat /var/log/syslog`
2. **Check User Permissions:**
    
    - **Command:** `id username`
    - **Example:** `id john_doe`
3. **Check Running Processes:**
    
    - **Command:** `ps aux`
    - **Example:** `ps aux`
4. **Check Listening Ports:**
    
    - **Command:** `netstat -tuln`
    - **Example:** `netstat -tuln`
5. **Check Network Configuration:**
    
    - **Command:** `ifconfig`
    - **Example:** `ifconfig`
6. **Check System File Integrity:**
    
    - **Command:** `sudo debsums -c`
    - **Example:** `sudo debsums -c`
7. **Check Open Files:**
    
    - **Command:** `lsof`
    - **Example:** `lsof`
8. **Check Active Network Connections:**
    
    - **Command:** `netstat -anp`
    - **Example:** `netstat -anp`
9. **Check Disk Space Usage:**
    
    - **Command:** `df -h`
    - **Example:** `df -h`
10. **Check System Uptime:**
    
    - **Command:** `uptime`
    - **Example:** `uptime`
11. **Check for Expired Passwords:**
    
    - **Command:** `sudo chage -l username`
    - **Example:** `sudo chage -l john_doe`
12. **Check for World-Writable Files:**
    
    - **Command:** `find / -type f -perm -o+w`
    - **Example:** `find / -type f -perm -o+w`
13. **Check Failed Login Attempts:**
    
    - **Command:** `cat /var/log/auth.log | grep "Failed password"`
    - **Example:** `cat /var/log/auth.log | grep "Failed password"`
14. **Check for Rootkits:**
    
    - **Command:** `rkhunter --check`
    - **Example:** `rkhunter --check`
15. **Check SELinux Status:**
    
    - **Command:** `sestatus`
    - **Example:** `sestatus`