#!/bin/bash

# Check if running as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

# Update the system
yum -y update

# Install Git
yum -y install git

# Install required packages
yum -y install httpd mod_security mod_security_crs

# Create ModSecurity CRS directories
mkdir -p /etc/httpd/modsecurity.d/owasp-crs
cd /etc/httpd/modsecurity.d

# Download and extract OWASP CRS rules
git clone https://github.com/SpiderLabs/owasp-modsecurity-crs.git owasp-crs
mv owasp-crs/crs-setup.conf.example owasp-crs/crs-setup.conf

# Configure ModSecurity
cp /etc/httpd/conf.d/mod_security.conf /etc/httpd/conf.d/mod_security.conf.bak

cat <<EOL > /etc/httpd/conf.d/mod_security.conf
<IfModule security2_module>
    <IfDefine MODSEC_ENABLED>
        Include modsecurity.d/owasp-crs/crs-setup.conf
        Include modsecurity.d/owasp-crs/rules/*.conf
        SecDefaultAction "phase:2,log,deny"
        SecAuditEngine RelevantOnly
        SecDebugLogLevel 0
        SecDebugLog /var/log/httpd/modsec_debug.log
    </IfDefine>
</IfModule>
EOL

# Create symbolic links for CRS rules with the correct path
ln -s /etc/httpd/modsecurity.d/owasp-crs/crs-setup.conf /etc/httpd/modsecurity.d/activated_rules/crs-setup.conf
ln -s /etc/httpd/modsecurity.d/owasp-crs/rules/REQUEST-900-EXCLUSION-RULES-BEFORE-CRS.conf /etc/httpd/modsecurity.d/activated_rules/REQUEST-900-EXCLUSION-RULES-BEFORE-CRS.conf
ln -s /etc/httpd/modsecurity.d/owasp-crs/rules/RESPONSE-999-EXCLUSION-RULES-AFTER-CRS.conf /etc/httpd/modsecurity.d/activated_rules/RESPONSE-999-EXCLUSION-RULES-AFTER-CRS.conf

# Restart Apache
systemctl restart httpd

echo "OWASP ModSecurity CRS setup is complete."
