### main.cf
##### Orig
	myhostname = mail.frog.com
	mydomain = frog.com
	local_recipient_maps = 
	mynetworks = 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16
	`alias_maps = hash:/etc/aliases, ldap:/etc/postfix/ldap-alias.cf`
	`alias_database = hash:/etc/aliases`
	`home_mailbox = Maildir/`
	`sendmail_path = /usr/sbin/sendmail.postfix`
	`newaliases_path = /usr/bin/newaliases.postfix`
	`mailq_path = /usr/bin/mail.postfix`
	`virtual_mailbox_maps = proxy:ldap:/etc/postfix/ad_virtual_mailbox_maps.cf`
	`smptd_sender_login_maps = proxy:ldap:/etx/postfix/ad_sender_login_maps.cf`

##### CCDC
	mynetworks = <netowrk1/24, network2/24,>

### Ldap config files: 
	'/etc/postfix/ad_virtual_mailbox_maps.cf'
	`/etc/postfix/ad_sender_login_maps.cf`
	`/etc/postfix/ldap-alias.cf`
	
##### Orig
	`server_host = <ad server>`
	`server_port = <port>`

##### Check bind connection:
	*Check bind_dn <user>*
	*Check bind_pw <password>*
	(If these users/passowrds change the ldap link will break.)

## Dovecot

### dovecot.conf
#### Orig
	`protocls = imap pop3 lmtp`
	`listen = *`


### Ldap config files: 
	`/etc/dovecot/dovecot-ldap.conf`
	

### Postfix Folders



##### Data
	`/var/lib/postfix`

ldap:/etc/postfix/ldap-alias.cf
/etc/aliases
virtual_mailbox_maps = proxy:ldap:/etc/postfix/as_virtual_mailbox_maps.cf
smptd_sender_login_maps = proxy:ldap:/etx/postfix/ad_sender_login_maps.cf

- **Install Postfix:**
    
    `sudo dnf install postfix`
    
- **Optionally install swaks - a tool useful to test mail connections and configuration:**
    
    `sudo dnf install postfix swaks`
    
- **Start/Enable Postfix service:**
    
    `sudo systemctl start postfix
    `sudo systemctl enable postfix`
    
- **Check mailbox of user:**
    
    `tail -f /var/mail/user`
    
- **List local Users**
    
    `getent passwd
    
- **Check maillog:**
    
    `tail -f /var/log/maillog`
    
- **Swaks commands:**
    send test email
    `swaks --to DESTINATIONEMAIL --from FROMEMAIL --helo SUBJECTLINE -s SMTPSERVER
    
