#!/bin/bash

# Define the path to the Apache configuration file
HTTPD_CONF="/etc/httpd/conf/httpd.conf"

# Write new configuration directly to httpd.conf
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
