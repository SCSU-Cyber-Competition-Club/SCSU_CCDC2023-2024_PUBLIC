#! /usr/bin/env bash

wget https://www.prestashop.com/download/old/prestashop_1.6.1.5.zip

unzip prestashop_1.6.1.5.zip

sudo chown -R apache: ~/prestashop/

sudo mv ~/prestashop/* /var/www/html/

sudo mv /var/www/html/admin/ /var/www/html/kdycau0197k8upr2/
