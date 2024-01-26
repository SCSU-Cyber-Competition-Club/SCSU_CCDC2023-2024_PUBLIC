## Viewing

*Open new terminal window*

	`Ctrl+Shift+T`

### *View using tail:*

_Default 10 lines_

	`sudo tail -f {logfile}`
_Custom number of lines_

	`sudo tail -n {#oflines} -f {logfile}`

### *View using vim:*

	`sudo vi {logfile}`

## Feodra

*System-Wide messages/information*

	`/var/log/messages`

*Authentication*

	`/var/log/secure`

*Failed login attmepts*  

	`journalctl -q _AUDIT_TYPE=1112 _TRANSPORT=audit | grep failed`
	`faillog -a`
	`grep sshd /var/log/secure`
	`journalctl _SYSTEMD_UNIT=sshd.service`

*Checking last logins*  

	`last`  
	
*SSH*

	`/var/log/secure`
	`journalctl -u SSHD`

*Cron*

	`/var/log/cron`
	`grep -i cron /var/log/syslog`
	
*View List of files opened by users*
	`lsof -u <user name>`

*Root user history*
	Bash
	`cat /root/.bash_history`

	Command History
	`cat /root/.*history `

*Firewall*

	`/var/log/iptables`

*Boot*

	`/var/log/boot.log`

*View accounts with UID 0 (Root)*

	`awk -F: '($3 == "0") {print}' /etc/passwd`  

*View List of files opened by users*

	`lsof -u <user name>`  


*Checking DHCP lease logs*  
`journalctl | grep -Ei 'dhcp'`  



## Journal logs
_Can be used to find logs:_

	`journalctl -u {servicename}`  
_Look at the output. Find an uncommon pattern/string in the output, say "foobar", and run a command like this:_

	`grep -R "foobar" /var/log/`



## Postfix/SMTPD
*Default*

	`/var/log/maillog`
*Alternate*

	`/var/log/mail.log`


## Dovecot

*Default Dovecot log location when using syslog*

	`/var/log/maillog`

*Possible Dovecot log location if not using syslog*

	`/var/log/dovecot.log`

*Find location of dovecot logs*

	`sudo doveadm log find`


## Exim

*Main Log*

	`/var/log/exim_mainlog`

*Reject Log*

	`/var/log/exim_mainlog`

*Panic Log*

	`/var/log/exim_mainlog`



#### Audit Logs to Syslog
_Possibly already done_

*Enable Logging of audit logs to syslog*

1) *Enable logging of audit logs to syslog:*
	`vim /etc/audisp/plugins.d/syslog.conf`
		change the following line: 
		   `active = no`
		   to: 
		   `active = yes`

 2) *Append to audit.rules to monitor critical files and network ops*
		`cd /etc/audit`
		`echo ‘-a always,exit -F dir=/etc/ -F perm=wa -k ETC’ >> audit.rules`
		`echo ‘-a always,exit -F arch=b64 -S listen -S accept -S connect -k SOCK’ >> audit.rules`


3) Reboot or restart auditd 
	`sudo systemctl restart auditd`
	`sudo systemctl  status auditd`
