## Public repo Link
https://github.com/SCSU-Cyber-Competition-Club/SCSU_CCDC2023-2024_PUBLIC.git
------
# Host Operating System Hardening

### (.5)
`sudo yum update ca-certificates`
##### (1) Change User Passwords
`sudo passwd <usertochange>`
###### Check for other users
`cat /etc/passwd | grep bash`
##### (2) Change Root User
`sudo su`
`sudo vim visudo` // *look for additional super users // add 2nd privilege account //*
`<user> ALL=(ALL:ALL) ALL` *// add 2nd user as root*
##### (3) Lock root account, no/login
`sudo passwd -l <account>` * // lock root account// *
`sudo usermod -s /sbin/nologin/<account>` *// change account to no login //
##### (4) Host Firewall rules
Looks like `firewalld` is running
`sudo yum install git` -> git clone our repo and run the `firewalld` script*


##### (5) Backups
~should be good~
##### (6) System Update
looks like doing a system update kind of breaks things
	- try sudo update and upgrade , probably should do this 
##### (7) Check / Start Services
- *Find services running:_ `systemctl list-unit-files --type=service | grep enabled` yum list installed*
- _Disabling services_ `systemctl disable service_name` `yum remove packageName`
##### (8) Check for unmounted Drives
~dont think we have anything to do hear`
##### (9) Checking Malicious Process
continually check `ps` or `ps aux` 
##### (10) Setting up forwarder
working on script still

------
# Service Hardening 

## Apache

#### (1) Things to add to `etc/httpd/conf/httpd.conf`
- `ServerSignature Off`
- `TraceEnable Off`
- `ServerTokens Prod`
- `Header set X-XSS-Protection "1; mode=block"`
- `Header set X-Frame-Options: "SAMEORIGIN"`

##### edit directory permissions
`chmod –R 750 bin conf`
##### modsecurity
`sudo yum install mod_security -y` // installing modsecurity
`sudo yum install mod_security_crs`
`sudo systemctl restart httpd`
##### mod_evasive (not sure if i need) 
`sudo yum install mod_evasive -y`
`sudo systemctl restart httpd`

## Mariadb
`mysqladmin password <newpassword>` // this changes the database password
`mysql -u root -p login to database` // now input new password //
##### Common commands for mariadb
`SHOW DATABASE;` // shows different databases
`USE prestashop` // you can USE command to access table
`SHOW TABLES;` // shows different tables
