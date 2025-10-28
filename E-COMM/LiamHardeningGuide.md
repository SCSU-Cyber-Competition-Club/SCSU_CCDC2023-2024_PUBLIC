1. Log in credentials: `root : changeme`
                       `sysadmin : changeme`
2. localhost - check webpage

`sudo passwd [username]`

Check users - `cat /etc/passwd | grep bash`

Check for apache user: `cat /etc/passwd | grep apache`

lock accounts with `sudo passwd -l [username]`

3. Change root password 

4. Change sysadmin password

5. Change accounts to no login: `usermod -s /sbin/nologin [username]`

6. backup /var/www/html to /opt/html.BAK.1 using `cp -R /var/www/html /opt/html.BAK.1`

7. change mysql password on whatever machine is hosting mysql: `mysqladmin -u root password "[new password]"`
                                                              `mysql -u root-p mysql`
                                                              `update user set password=PASSWORD("[new password]") where user='root';`
                                                              `flush privileges;`

9. Change firewall rules, basic script is located in SCSU github as well. (`sudo firewall-cmd --list-all` will list all firewall rules to double check them)

10. configure apache server, /etc/httpd/conf/httpd.conf is userful. Look at Apache and MySQL checklist.
 Basically, you add an apache group and an apache user, apache user has no login. `sudo useradd -r -s /sbin/nologin -g apache_group apache_user` . Then you change the ownership of the /www/ folder to the apache user and apache group
  `sudo chown -R apache_user:apache_group /path/to/your/document/root`

 add `User apache_user`
 add `Group apache_group`
 to /etc/httpd/conf/httpd.conf

12. `sudo yum update ca-certificates` to update certs

13. finding services running: `systemctl list-unit-files --type=service | grep enabled`

14. disabling services: `systemctl disable service_name` or `yum remove packagename`

15. changing /etc/httpd/conf/httpd.conf to harden service: (remember in vim use `/.` to find things fast)
    `ServerSignature Off`
    `TraceEnable Off`
    `ServerTokens Prod`
    `Header set X-XSS-Protection "1; mode=block"`
    `Header set X-Frame-Options: "SAMEORIGIN"`

16. use `sudo netstat -plant` for tcp and `sudo netstat -planu` for udp to find connections.

17. `crontab -l` to check services, `crontab -u [user]` to list a specific user

18. `top` or `ps` to view processes running in the background.

19. `kill -9 [pid]` to kill processes

20. 
