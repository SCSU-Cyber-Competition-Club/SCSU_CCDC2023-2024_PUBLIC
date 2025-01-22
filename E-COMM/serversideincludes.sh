#!/bin/bash

# Define variables
HTTPD_CONF="/etc/httpd/conf/httpd.conf"

# Write configuration to httpd.conf
cat <<EOF > $HTTPD_CONF
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

# Test the configuration
if apachectl configtest; then
    # Restart Apache to apply changes
    systemctl restart httpd
    if systemctl is-active --quiet httpd; then
        echo "Apache restarted successfully with SSI turned off."
    else
        echo "Apache failed to restart. Check the configuration for errors."
    fi
