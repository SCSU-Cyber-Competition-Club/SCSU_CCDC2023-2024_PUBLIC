## Managing User Accounts and Access

*changing user passwords* 
`sudo passwd username`

*checking for user accounts:*
`cat /etc/passwd | grep bash`

*locking user accounts*: 
`sudo passwd -l root` 

## List Open Connections
*netstat* 
`netstat -plant` (tcp)
`netstat -planu` (udp)

## Processes/Executables 
to kill: `kill -9 [PID]`
if you find malicious process write the name down

*Search Running Processes | Look For /bin/sh or /bin/bash and Misspelled Processes*
`ps`
`ps -ef`
`ps aux`

## Disabling Unnecessary Services

*Find services running:*
`systemctl list-unit-files --type=service | grep enabled`
yum list installed`

*Disabling services* 
`systemctl disable service_name`
`yum remove packageName`
## SSH

##### Putting SSH on non-standard port
*after making and changes too ssh run: `sudo systemctl restart sshd`* 

1) *Edit ssh config file*
`sudo vim /etc/ssh/sshd_config`

2) *In that file look for the line:*
	`#Port 22`

3) *Uncomment and Change that line to the desired port:*
	`Port 13350`
	
4) *Save and close*

5) *Restart ssh.*
   
##### If using SELinux: 

1) *Check to see if SELinux is Enforcing*
	`sestatus`

2) *List ports* 
 `Sudo semanage port -l | grep ssh`	

3) *Add New Port to SELinux Policy
	`sudo semanage port -a -t ssh_port_t -p tcp [desired port]`


##### Configuring Firewall rules for SSH change

1) *Opening New Port for SSH:*
   `sudo firewall-cmd --add-port=33000/tcp --permanent`
 
 2) *Update Firewall rule*
    `sudo firewall-cmd --reload`

3) *Disabling the standard SSH port*
	`sudo firewall-cmd --remove-service=ssh --permanent`	

4) Reload firewall
   `sudo firewall-cmd --reload`

5) Restart SSH daemon
   `sudo systemctl restart sshd`

##### Disabling root login
`sudo vim /etc/ssh/sshd_config`

locate the line `PermitRootLogin`

change to: `PermitRootLogin no`

##### Disallow anonymous access 
add line `AllowUsers !nobody`

#### Check access to cron jobs
`sudo vim /etc/security/access.conf`

## Checkinf File System Premissions 
`ls -l directory_or_file`

*be sure to check*
- /etc
- /var/log
- /root
- /home
- /usr/bin, /usr/sbin
- /etc/sudoers/
- /var/www /var/www/html
- /etc/ssh
- /etc/pam.d
