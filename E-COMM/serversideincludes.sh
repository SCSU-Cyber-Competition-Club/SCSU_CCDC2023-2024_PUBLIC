#!/bin/bash

# Define the path to the Apache configuration file
HTTPD_CONF="/etc/httpd/conf/httpd.conf"

# Backup the current configuration
echo "Backing up the current httpd.conf..."
cp "$HTTPD_CONF" "${HTTPD_CONF}.backup.$(date +%F-%T)"

# Overwrite the configuration with your settings
cat <<EOF > "$HTTPD_CONF"
# Global server configuration
<Directory />
    Require all denied
    Options None
    AllowOverride None
</Directory>

<Directory /web>
    Require all granted
    Options -Includes
    AllowOverride None
</Directory>
EOF

# Test the new configuration
echo "Testing the Apache configuration..."
if apachectl configtest; then
    echo "Configuration test passed."

    # Restart Apache to apply changes
    echo "Restarting Apache..."
    systemctl restart httpd
    if systemctl is-active --quiet httpd; then
        echo "Apache restarted successfully."
    else
        echo "Apache failed to restart. Check the service status and logs for errors."
        systemctl status httpd
    fi
else
    echo "Configuration test failed. Restoring the backup..."
    cp "${HTTPD_CONF}.backup.$(date +%F-%T)" "$HTTPD_CONF"
    apachectl configtest
fi
