#!/bin/bash

# Define variables
HTTPD_CONF="/etc/httpd/conf/httpd.conf"

# Write configuration to httpd.conf
cat <<EOF > $HTTPD_CONF
# Global server configuration
<Directory />
  Order Deny,Allow
  Deny from all
  Options None
  AllowOverride None
</Directory>

<Directory /web>
  Order Allow,Deny
  Allow from all
  Options -ExecCGI
  AllowOverride None
</Directory>
EOF

# Restart Apache to apply changes
systemctl restart httpd

# Status check
if systemctl is-active --quiet httpd; then
  echo "Apache restarted successfully with CGI execution turned off."
else
  echo "Apache failed to restart. Check the configuration for errors."
fi
