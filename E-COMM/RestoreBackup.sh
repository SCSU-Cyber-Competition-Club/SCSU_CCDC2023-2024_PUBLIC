#! /bin/bash

#Liam Browning

#Restoring MySQL Backup (Comment this out if it was a website defacement)

mysql -u root -p prestashop < /root/prestashop_backup.sql

#Restoring HTML file backups

cp -r /root/html.bak.1 /var/www/html/prestashop_backup

mv /var/www/html/prestashop /var/www/html/prestashop-old

mv /var/www/html/prestashop_backup /var/www/html/prestashop

#setting owner of all directories to apache

chown -R apache:apache /var/www

systemctl restart httpd

echo -e 'Prestashop should be fixed, please re-harden Prestashop and connect to the Database using the mysql password via prestashop config files'
