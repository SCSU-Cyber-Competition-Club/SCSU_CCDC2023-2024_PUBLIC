## Get scripts

##### Set name servers: 
	`sudo vi /etc/resolv.conf` 
	(Add the following prior to the other nameserver lines) 
	`nameserver 8.8.8.8` 

##### Install Git: 
	`sudo apt install git -y` 

##### Clone the git repository: 
	`git clone https://github.com/SCSU-Cyber-Competition-Club/SCSU_CCDC2023-2024_PUBLIC.git` 

## Managing User Accounts and Access 

##### Checking for user accounts: 
	`cat /etc/passwd | grep bash` 

##### Lock users:
(Do not run if root user is already disabled.) 
(Check if needed users/services have ID's over 5000) 
	`cat /etc/passwd` 

##### Nologin Script: 
	`sudo ./bash ./SCSU_CCDC2023-2024_PUBLIC/Web-Mail/nologin.sh` 

##### Create new root user: 
	`sudo useradd username` 
	`usermod -aG wheel username' 

##### Change new root user password: 
	`sudo passwd username` 

##### Log off root and log in with newly created "wheel" user:  
	`logout` 

##### checking for sudoers user/groups: 
	(These will be listed under User Aliases and %wheel group lines.) 
	(Remove users that do not need sudo privilege's.) 
	`sudo visudo` 

##### adding user to sudoers file: 
	`sudo visudo` 

##### locking user accounts: 
	`sudo passwd -l root` 


## List Open Connections
##### Use netstat to check open connections: 
	`netstat -plant` (tcp) 
	`netstat -planu` (udp) 

## Apply IPtables rules
(Note any special ports with the netstat command that may need to be added to iptables)
	`sudo bash ./SCSU_CCDC2023-2024_PUBLIC/Web-Mail/firewall.sh` 

*Example on adding rule to allow in and out Splunk traffic on TCP port 9997* 
	`iptables -A OUTPUT -p tcp --dport 9997 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT` 
	`iptables -A INPUT -p tcp --sport 9997 -m conntrack --ctstate ESTABLISHED -j ACCEPT` 

##### List iptable rules: 
	`iptables -L -v -n` 

##### Save iptables rule changes for persistence: 
	`sudo iptables-save > /etc/sysconfig/iptables` 

##### iptables config file: 
	`/etc/sysconfig/iptables` 


## Processes/Executables 
to kill: `kill -9 [PID]` 

if you find malicious process write the name down

##### Search Running Processes: 
*Look For /bin/sh or /bin/bash and Misspelled Processes* 
	`ps` 
	`ps -ef` 
	`ps aux` 

## Disabling Unnecessary Services 

##### Find services running:
	`systemctl list-unit-files --type=service | grep enabled` 
	`systemctl --type=service --state=running`

##### Disabling services: 
	`systemctl disable service_name` 

## Selinux

##### *Check to see if SELinux is Enforcing*  
	`sestatus` 

##### *Install semange* 
	`sudo yum install policycoreutils-python-2.3-8.fc21.x86_64` 

##### *List ports*  
	 `Sudo semanage port -l | grep ssh`	

## Install Anti-virus
	`sudo apt install clamav clamav-daemon -y`
	`clamconf -g freshclam.conf`
	`clamconf -g clamd.conf > clamd.conf`
	`clamconf -g clamav-milter.conf > clamav-milter.conf`
```
## SSH 

##### Restarting SSH 
   `sudo systemctl restart sshd` 

##### SSH config file 
	`sudo vi /etc/ssh/sshd_config` 

##### Harden SSH 
*The following script will modify the sshd_config and change the port it uses too restarting the sshd service and setting the new port in selinux* 

	`sudo bash ./SCSU_CCDC2023-2024_PUBLIC/Web-Mail/ssh.sh` 

##### Changes made to sshd_config: 
	`PermitRootLogin` 
	`PermitRootLogin no` 
	`AllowUsers !nobody` 
	`Port 13350` 

##### Selinux port changing:  
	`sudo semanage port -a -t ssh_port_t -p tcp 13350` 

## Check access to cron jobs:  
	`sudo vim /etc/security/access.conf` 

## Checkinf File System Premissions 
	`ls -l directory_or_file`


## Secure cron

 To prevent users except for root from creating cron jobs, perform the following steps.

1) Create an empty file /etc/cron.allow:
	`sudo touch /etc/cron.allow`

2) Allow users to create cron jobs by adding their usernames to the file:
	`sudo echo "{username}" >> /etc/cron.allow`

3) To verify, try creating a cron job as non-root user listed in cron.allow. You should see the message:
	`crontab -e`
	`no crontab for "{username}" - using an empty one`

4) Quit the crontab editor and try the same with a user not listed in the file (or before adding them in step 2 of this procedure):
	`crontab -e`
	`You ({username}) are not allowed to use this program (crontab)`
	`See crontab(1) for more information`


## Secure at

To prevent users except for root from scheduling jobs with at, perform the following steps.  

1) Create an empty file /etc/at.allow:  
	`sudo touch /etc/at.allow`

2) Allow users to schedule jobs with at by adding their usernames to the file:
	`sudo echo "{username}" >> /etc/at.allow`

3) To verify, try scheduling a job as non-root user listed in at.allow:  
	`at 00:00`
	`at>`  

4) Quit the atprompt with Ctrl–C and try the same with a user not listed in the file (or before adding them in step 2 of this procedure):  
	`at 00:00`
	`You do not have permission to use at.`




*be sure to check*
- /etc
- /var/log
- /root
- /home
- /usr/bin 
- /usr/sbin
- /etc/sudoers/
- /var/www 
- /var/www/html
- /etc/ssh
- /etc/pam.d