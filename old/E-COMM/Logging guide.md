##### *checking  login attempts*
- `grep sshd /var/log/secure`
- `journalctl _SYSTEMD_UNIT=sshd.service`
- `tail /var/log/auth.log`
##### *checking authentication log files*
`grep sshd /var/log/auth.log`


##### *checking last logins*
`last` 
##### *Checking DHCP lease logs*
`cat /var/lib/dhcpd/dhcpd.leases`
##### *Checking Cron activity*
`grep -i cron /var/log/syslog`
##### *Checking Sudo activity*
`grep -i sudo /var/log/auth.log`
##### *View Failed Logins*
`faillog -a`
##### *View accounts with UID 0 (Root)*
`awk -F: '($3 == "0") {print}' /etc/passwd`
##### *View List of files opened by users*
`lsof -u <user name>`
##### *Root user history*

##### *Network Traffic*
`netstat -plant` for TCP
`netstat -planu` for UDP

Bash
`cat /root/.bash_history`

Command History
`cat /root/.*history `
