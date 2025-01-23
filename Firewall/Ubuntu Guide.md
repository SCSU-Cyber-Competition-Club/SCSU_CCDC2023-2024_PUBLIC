
| System Name | OS                   | Configuration            | Username | Password |
| ----------- | -------------------- | ------------------------ | -------- | -------- |
| Ubuntu Wkst | Ubuntu Desktop 20.04 | DHCP (172.20.242.101/24) | sysadmin | changeme |
User: sysadmin
Pass: changeme

## Change Admin/Root Password
`passwd`
`sudo passwd  <username>`

## Check Users
`cat \etc\passwd`

`awk -F: '($3 >= 1000) && /\/bin\/bash|\/bin\/sh|\/bin\/zsh/ {print $1}' /etc/passwd`

## Lock Users Not needed.
`sudo passwd -l <username>`

## Check Running Services
`systemctl list-units --type=service --state=running`

## Stop/Disable Print Service
`sudo systemctl stop cups.service cups-browsed.service`
`sudo systemctl disable cups.service cups-browsed.service`

## Check open connections
`ss -tulpn`

## Check and remove Cron Jobs
Current user's jobs
`crontab -r`

System-wide jobs
`sudo nano /etc/crontab`

## Check Sudoers
`sudo visudo`

## Set Static IP
Set IP to use the following
	IP: 172.20.242.101/24
	DNS: 8.8.8.8
	Gateway: 172.20.242.254 