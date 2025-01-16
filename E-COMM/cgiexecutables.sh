#!/bin/bash

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root."
   exit 1
fi

echo "Starting secure CGI configuration for Apache..."

# Enable the CGI module
echo "Enabling CGI module..."
a2enmod cgid

# Backup the current Apache configuration file
APACHE_CONF="/etc/apache2/apache2.conf"
BACKUP_CONF="/etc/apache2/apache2.conf.bak"

if [[ ! -f $BACKUP_CONF ]]; then
    echo "Backing up Apache configuration to $BACKUP_CONF..."
    cp $APACHE_CONF $BACKUP_CONF
fi

# Add secure CGI configurations to the Apache configuration file
echo "Adding secure CGI configurations to Apache configuration..."
cat <<EOL >> $APACHE_CONF

# Secure CGI Configuration
# Restrict CGI execution to /cgi-bin
ScriptAlias "/cgi-bin/" "/usr/lib/cgi-bin/"

<Directory "/usr/lib/cgi-bin/">
    Options +ExecCGI -Indexes
    AllowOverride None
    Require all granted
</Directory>

# Disable user-specific CGI directories
# Commented out to prevent execution in user directories
# <Directory "/home/*/public_html/cgi-bin">
#     Options +ExecCGI
#     SetHandler cgi-script
#     Require all granted
# </Directory>

# AddHandler to specify CGI file types
AddHandler cgi-script .cgi .pl

# Enable logging for CGI activities
LogLevel debug

EOL

# Set permissions for the /cgi-bin directory
echo "Setting secure permissions for /usr/lib/cgi-bin/..."
chmod -R 750 /usr/lib/cgi-bin/
chown -R root:root /usr/lib/cgi-bin/

# Create a secure Bash CGI script
CGI_SCRIPT="/usr/lib/cgi-bin/example-bash.sh"

if [[ ! -f $CGI_SCRIPT ]]; then
    echo "Creating secure example Bash CGI script: $CGI_SCRIPT..."
    cat <<'SCRIPT' > $CGI_SCRIPT
#!/bin/bash
# Secure Bash CGI Script

# Validate input to prevent command injection
sanitize_input() {
    local input="$1"
    echo "$input" | sed 's/[^a-zA-Z0-9 _-]//g'
}

# Output content
echo "Content-type: text/html"
echo ""
echo "<html><head><title>Secure CGI Bash Example</title></head><body>"
echo "<h1>Welcome to the Secure Bash CGI Script!</h1>"

# Example sanitized input handling (for demonstration purposes)
query_string=$(sanitize_input "$QUERY_STRING")
echo "<p>Query string sanitized: $query_string</p>"

echo "</body></html>"
SCRIPT

    chmod 750 $CGI_SCRIPT
    chown root:root $CGI_SCRIPT
fi

# Restart Apache to apply changes
echo "Restarting Apache server to apply changes..."
systemctl restart apache2

echo "Secure CGI configuration completed successfully!"
echo "Test your CGI script by visiting http://your-server-ip/cgi-bin/example-bash.sh"
