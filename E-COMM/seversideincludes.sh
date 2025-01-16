#!/bin/bash

echo "Starting Secure SSI configuration..."

# Enable SSI module
echo "Enabling Includes in Apache configuration..."
sudo a2enmod include

# Restrict SSI to specific directories and disable 'exec'
echo "Configuring secure SSI in Apache..."
cat <<EOF | sudo tee /etc/apache2/conf-available/secure-ssi.conf
<Directory /var/www/html/secure-ssi>
    Options +IncludesNOEXEC
    AllowOverride None
    Require all granted
</Directory>
EOF

sudo a2enconf secure-ssi

# Disable directory indexing
echo "Disabling directory indexing..."
sudo sed -i '/<Directory \/>/,/<\/Directory>/ s/Options .*/Options -Indexes/' /etc/apache2/apache2.conf

# Enable HTTPS if not already enabled
echo "Ensuring HTTPS is enabled..."
sudo a2enmod ssl
sudo a2ensite default-ssl

# Restart Apache to apply changes
echo "Restarting Apache to apply changes..."
sudo systemctl restart apache2 || {
    echo "Error restarting Apache. Check 'systemctl status apache2' and 'journalctl -xe' for details."
    exit 1
}

echo "Secure SSI configuration completed successfully!"
