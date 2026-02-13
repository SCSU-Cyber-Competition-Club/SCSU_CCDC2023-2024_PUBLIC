
the main file you will be needing to configure to harden will be the :
`/etc/httpd/conf/httpd.conf`

#### make sure to always restart the httpd server after configuration changes have been made

#### Creating new user and group for Apache server:
- create new group `sudo groupadd apache_group`
- create a new user `sudo useradd -r -s /sbin/nologin -g apache_group apache_user`
- set permissions `sudo chown -R apache_user:apache_group /path/to/your/document/root`

- in the  */etc/httpd/conf/httpd.conf* `update User apache_user, Group apache_group`
  - restart httpd service `systemctl restart httpd`
#### Config file hardening 
A couple of key things to change here in `/etc/httpd/conf/httpd.conf` are:

- edit or add `ServerSignature Off`
  
- edit or add `TraceEnable Off`

- Add `ServerTokens Prod` 

- change or delete the *Indexes* option out of: (normally Indexes will be between Options and FollowSymLinks)
  `Options FollowSymLinks` 
  
- make sure .htaccess is set to all denied:
  *will look like this below*
```
<Files ".ht*">
    Require all denied
</Files>
```
##### Check Apache logs
`cat /var/log/httpd/access_log`
`cat /var/log/httpd/error_log`




