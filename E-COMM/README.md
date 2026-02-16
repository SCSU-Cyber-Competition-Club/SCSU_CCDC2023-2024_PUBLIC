# SCSU_CCDC_Service_Leaders_Content
# Setting up our E-commerce VM
[centos 7 setup guide]{https://www.unixmen.com/install-prestashop-centos-7-linux/}
We will be focusing on a couple of components for our e-commerce server.

Last years competition used the *Prestashop framework* so we will be learning how to set that up on our [[CentOS 7]] machine.

- Apache Web Server
- MariaDB
- PHP modules
- Prestashop

#### Step 1: Update the System

 ```
sudo yum update

sudo reboot
```

#### Step2: Install and configure [[Apache Web Server]]

````
sudo yum install httpd

sudo systemctl start httpd.service

sudo systemctl enable httpd.service
````

   **Modify the current firewall rules so that visitors can access your online store:
   
```
sudo firewall-cmd --zone=public --permanent --add-service=http

sudo firewall-cmd --reload
```

#### Step 3: Install and configure [[MariaDB]]

**Install MariaDB and set it to automatically start after system reboot:

```
sudo yum install mariadb mariadb-server

sudo systemctl start mariadb.service

sudo systemctl enable mariadb.service
```

**Execute the secure MySQL installation process:

```
sudo /usr/bin/mysql_secure_installation
```

**Go through the process in accordance with the instructions below:

```
Enter current password for root (enter for none): Press the Enter key

Set root password? [Y/n]: Input Y, then press the Enter key

New password: Input a new root password, then press the Enter key

Re-enter new password: Input the same password again, then press the Enter key

Remove anonymous users? [Y/n]: Input Y, then press the Enter key

Disallow root login remotely? [Y/n]: Input Y, then press the Enter key

Remove test database and access to it? [Y/n]: Input Y, then press the Enter key

Reload privilege tables now? [Y/n]: Input Y, then press the Enter key
```

**Now, log into the MySQL shell so that you can create a dedicated database for PrestaShop:

```
mysql -u root -p
```

**Input the MariaDB root password you set earlier to log in, then setup the PrestaShop database using the following commands.

```
CREATE DATABASE prestashop;

USE prestashop;

GRANT ALL PRIVILEGES ON prestashop.* TO 'prestashopuser'@'localhost' IDENTIFIED BY 'yourpassword' WITH GRANT OPTION;

FLUSH PRIVILEGES;

EXIT;
```

#### Step 4: Install PHP and required extensions:

**Install PHP and required extensions using YUM:

```
sudo yum install php php-gd php-mbstring php-mcrypt php-mysqli php-curl php-xml php-cli
```

Put all of the configuration changes into effect:

```
sudo systemctl restart httpd mariadb
```
#### Step 5: Download the [[Prestashop]] archive and prepare for installation

Download the latest stable version of PrestaShop, which is `1.6.1.5` as of writing:

```
cd ~

wget https://www.prestashop.com/download/old/prestashop_1.6.1.5.zip
```

For future reference, you can always find the URL of the latest download from the PrestaShop official website.

Install `unzip` to uncompress the archive:

```
sudo yum install unzip

unzip prestashop_1.6.1.5.zip
```

Setup the proper ownership for all of the files and directories in the archive, then move them to the web root directory:

```
sudo chown -R apache: ~/prestashop/

sudo mv ~/prestashop/* /var/www/html/
```

#### Step 6: Finish the installation from a web browser 

Visit your Vultr server from a web browser:

```
http://[your-Vultr-server-IP]/
```

For security purposes, you **MUST** delete the `/install` directory after the installation:

```
sudo rm -rf /var/www/html/install/
```

You **MUST** rename the `/admin` directory to a private and secure name (e.g. `/kdycau0197k8upr2`) before you can manage the store. Choose a secure name. For example:

```
sudo mv /var/www/html/admin/ /var/www/html/kdycau0197k8upr2/
```

Afterwards, you would manage the store from the following URL:

```
http://[your-Vultr-server-IP]/kdycau0197k8upr2/
```
## Configure Virtual Host (Optional):

If you haven't already, you might want to set up a virtual host for your PrestaShop installation. Edit your Apache configuration file (usually located in /etc/httpd/conf/httpd.conf or /etc/apache2/sites-available/) to include a virtual host entry for your PrestaShop site.

Example Virtual Host configuration:

apache
Copy code
<VirtualHost *:80>
    ServerAdmin webmaster@example.com
    DocumentRoot /var/www/html/prestashop
    ServerName your_domain

    <Directory /var/www/html/prestashop>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog /var/log/httpd/prestashop_error.log
    CustomLog /var/log/httpd/prestashop_access.log combined
</VirtualHost>
Remember to adjust paths, server names, and other settings based on your specific setup.
