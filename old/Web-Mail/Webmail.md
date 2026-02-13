## Postfix

https://www.linuxbabe.com/mail-server/block-email-spam-postfix
https://www.postfix.org/LDAP_README.html

Check postifx status:  
`sudo postfix status`  

### Check for errors
	`postfix check`
	`grep -E '(reject|warning|error|fatal|panic):' /some/log/file`

/etc/syslog.conf:
    mail.err                                    /dev/console
    mail.debug                                  /var/log/maillog

### Common Settings

Interfaces that listening for SMTP
`inet_interfaces = all`

Domain used:  
`mydomain = local.domain`

hostname of postfix:  
`myhostname = host.local.domain`



### Postfix TLS Configuration

Set TLS Certificate:  
`smtpd_tls_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem`
Set TLS Key:  
`smtpd_tls_key_file=/etc/ssl/private/ssl-cert-snakeoil.key`
Set SMTP to use tls:  _no, yes_
`smtpd_use_tls=yes`  
Set TLS to mandatory:  _none, may, encrypt_  
`smtp_tls_security_level=encrypt`

## LDAP  

Alias mapping:  
_In main.cf of the postfix config_
`/etc/postfix/main.cf`  
Lines
alias_maps = hash:/etc/aiases, ldap:/etc/postfix/ldap-aliases.cf

In **ldap.aliases.cf**  `/etc/postfix/ldap.aliases.cf`  
Determine the domains it is set up for ldap by the following lines:  
server_host = ldap.example.com
search_base = dc.=example, dc=com


Examples of ldap users/groups in ldap.aliases.cf


### ldap group alias
Example for group CCDC on domain example.com  
	_The CCDC group includes users/members dustin, thomas._

     dn: cn=bgroup, dc=example, dc=com
     objectclass: top
     objectclass: ldapgroup
     cn: CCDC
     mail: CCDC@example.com
	maildrop: CCDC@mlm.example.com
	memberdn: uid=user, dc=example, dc=com
	memberdn: uid=user2, dc=example, dc=com
	memberaddr: user@example.org
	memberaddr: user2@example.org

### ldap user alias
Example for user dustin on domain example.com  

     dn: uid=user, dc=example, dc=com
     objectclass: top
     objectclass: ldapuser
     uid: duser
	mail: user@example.com
	maildrop: user@mailhub.example.com



## Handling SPAM


In the main.cf  
`sudo nano /etc/postfix/main.cf`

Add the following line inside `smtpd_sender_restrictions =`.   

Reject an email if the client IP address has no PTR record.  
`reject_unknown_reverse_client_hostname`

Reject Email if SMTP Client Hostname doesn’t have valid A Record  
`reject_unknown_client_hostname`  

Reject email if the domain name of the address supplied with the MAIL FROM command has neither MX record nor A record.
`reject_unknown_sender_domain`

Example:  

	smtpd_sender_restrictions =
	   permit_mynetworks
	   permit_sasl_authenticated
	   reject_unknown_reverse_client_hostname
	   reject_unknown_client_hostname
	   reject_unknown_sender_domain

Save and close the file. Then restart Postfix for the change to take effect.  

`sudo systemctl restart postfix`



## Maildir

Configure Postfix to use Maildir
`sudo postconf -e "home_mailbox = Maildir/"`

Modify parameter of postfix
`sudo postconf -e {parameter}``


[Information Maildir](https://doc.dovecot.org/configuration_manual/mail_location/Maildir/)


### Dovecot

Dovecot config locations:  
`sudo vim /etc/dovecot/conf.d`
`sudo vim /etc/dovecot/dovecot.conf`

Protocols:  
`protocols = pop3`  

SSL Certs:  
ssl_cert = </etc/ssl/certs/imap.pem

[Information](https://doc.dovecot.org/configuration_manual/)

- Update:*
    
    `sudo dnf upgrade --refresh -y`
    
- **Change HostName:**
    
    `hostnamectl set-hostname new-name`
    *hostname needs to match the hostname of the postfix config*
    
- **Reboot now:**
    
    `sudo shutdown -r now`
    
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
    
