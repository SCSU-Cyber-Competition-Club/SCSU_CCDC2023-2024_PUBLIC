#!/bin/bash

# Define the path to the Apache configuration file
HTTPD_CONF="/etc/httpd/conf/httpd.conf"

# Overwrite the configuration with the desired setup
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
if apachectl configtest; then
    echo "Configuration test passed."

    # Restart Apache to apply changes
    systemctl restart httpd
    if systemctl is-active --quiet httpd; then
        echo "Apache restarted successfully with the updated configuration."
    else
        echo "Apache failed to restart. Check the service status and logs for errors."
        systemctl status httpd
    fi
else
    echo "Configuration test failed. No changes applied."
    apachectl configtest
fi
