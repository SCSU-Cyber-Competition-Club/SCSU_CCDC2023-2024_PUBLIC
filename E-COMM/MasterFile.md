## Public repo Link
`git clone https://github.com/SCSU-Cyber-Competition-Club/SCSU_CCDC2023-2024_PUBLIC.git`
------
# Host Operating System Hardening

#### (1) Change User Passwords
`sudo passwd <usertochange>`
##### Check for other users
`cat /etc/passwd | grep bash`
#### (2) Change Root User
`sudo su`
`sudo vim visudo` // *look for additional super users // add 2nd privilege account //*
`<user> ALL=(ALL:ALL) ALL` *// add 2nd user as root*
#### (3) Lock root account, no/login
`sudo passwd -l <account>` * // lock root account// *
`sudo usermod -s /sbin/nologin/<account>` *// change account to no login //
#### (4) Host Firewall rules
Looks like `firewalld` is running
`sudo yum install git` -> git clone our repo and run the `firewalld` script*
##### (5) Backups

#### (6) System Update
looks like doing a system update kind of breaks things
	- try sudo update and upgrade , probably should do this 
#### (7) Check / Start Services
- *Find services running:_ `systemctl list-unit-files --type=service | grep enabled` yum list installed*
- _Disabling services_ `systemctl disable service_name` `yum remove packageName`
##### (8) Check for unmounted Drives

#### (9) Checking Malicious Process

#### (10) Setting up forwarder


------
# Service Hardening 

### Apache




