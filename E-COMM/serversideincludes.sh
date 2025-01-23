#!/bin/bash

# Define the path to the Apache configuration file
HTTPD_CONF="/etc/httpd/conf/httpd.conf"

# Backup the current configuration
cp $HTTPD_CONF ${HTTPD_CONF}.backup.$(date +%F-%T)

# Append or modify specific sections
sed -i '/<Directory \/>/,/<\/Directory>/c\<Directory />\n    Require all denied\n    Options None\n    AllowOverride None\n</Directory>' $HTTPD_CONF
sed -i '/<Directory \/web>/,/<\/Directory>/c\<Directory /web>\n    Require all granted\n    Options -Includes\n    AllowOverride None\n</Directory>' $HTTPD_CONF

# Test the new configuration
if apachectl configtest; then
    # Restart Apache to apply changes
    systemctl restart httpd
    if systemctl is-active --quiet httpd; then
        echo "Apache restarted successfully with SSI turned off."
    else
        echo "Apache failed to restart. Check the configuration for errors."
    fi
else
    echo "Configuration test failed. Apache was not restarted."
fi
