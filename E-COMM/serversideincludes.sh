#!/bin/bash

# Define the path to the Apache configuration file
HTTPD_CONF="/etc/httpd/conf/httpd.conf"

# Backup the current configuration
echo "Backing up the current httpd.conf..."
cp "$HTTPD_CONF" "${HTTPD_CONF}.backup.$(date +%F-%T)"

# Update only the <Directory /> and <Directory /web> sections
echo "Updating <Directory /> and <Directory /web> sections..."
sed -i '/<Directory \/>/,/<\/Directory>/c\<Directory />\n    Require all denied\n    Options None\n    AllowOverride None\n</Directory>' "$HTTPD_CONF"
sed -i '/<Directory \/web>/,/<\/Directory>/c\<Directory /web>\n    Require all granted\n    Options -Includes\n    AllowOverride None\n</Directory>' "$HTTPD_CONF"
echo "LoadModule mpm_event_module modules/mod_mpm_event.so" >> /etc/httpd/conf/httpd.conf

# Test the updated configuration
echo "Testing the Apache configuration..."
if apachectl configtest; then
    echo "Configuration test passed."

    # Restart Apache to apply changes
    echo "Restarting Apache..."
    systemctl restart httpd
    if systemctl is-active --quiet httpd; then
        echo "Apache restarted successfully with the updated configuration."
    else
        echo "Apache failed to restart. Check the service status and logs for errors."
        systemctl status httpd
    fi
else
    echo "Configuration test failed. Restoring the backup..."
    cp "${HTTPD_CONF}.backup.$(date +%F-%T)" "$HTTPD_CONF"
    apachectl configtest
fi
