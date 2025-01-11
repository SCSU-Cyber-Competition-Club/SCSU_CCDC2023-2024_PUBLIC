#!/bin/bash

# Description: This script disables directory browsing in Apache by modifying the configuration file
#              and restarting the Apache service to apply changes.

# Step 1: Define paths for Apache configuration
APACHE_MAIN_CONF="/etc/httpd/conf/httpd.conf"      # Main Apache configuration file
APACHE_CONF_D="/etc/httpd/conf.d"                 # Additional configuration files

# Step 2: Locate and update the Options directive
disable_directory_browsing() {
    echo "Step 1: Locating the <Directory> directive in Apache configuration files..."
    
    # Check if the main configuration file exists
    if [ ! -f "$APACHE_MAIN_CONF" ]; then
        echo "Error: Apache main configuration file not found at $APACHE_MAIN_CONF."
        exit 1
    fi

    # Update the main configuration file to disable 'Indexes'
    echo "Step 2: Updating $APACHE_MAIN_CONF..."
    sed -i '/<Directory/s/Indexes//' "$APACHE_MAIN_CONF"

    # Check and update additional configuration files
    echo "Step 3: Updating additional configuration files in $APACHE_CONF_D..."
    grep -rl "<Directory" "$APACHE_CONF_D" | while read -r config_file; do
        echo "    Processing $config_file..."
        sed -i '/<Directory/s/Indexes//' "$config_file"
    done

    echo "Step 4: Adding a secure global <Directory> directive, if missing..."
    if ! grep -q "<Directory />" "$APACHE_MAIN_CONF"; then
        echo "    Adding secure default configuration to $APACHE_MAIN_CONF..."
        cat <<EOL >> "$APACHE_MAIN_CONF"

# Secure default configuration to prevent directory browsing
<Directory />
    Options -Indexes
    AllowOverride None
    Require all denied
</Directory>
EOL
    else
        echo "    Global <Directory /> directive already exists. No changes made."
    fi
}

# Step 3: Restart Apache service to apply changes
restart_apache() {
    echo "Step 5: Restarting the Apache service to apply changes..."
    systemctl restart httpd
    if [ $? -eq 0 ]; then
        echo "    Apache service restarted successfully."
    else
        echo "    Error restarting Apache service. Check the logs for details."
        exit 1
    fi
}

# Main function to execute the script steps
main() {
    echo "Disabling directory browsing in Apache..."
    
    # Ensure the script is run as root
    if [ "$(id -u)" -ne 0 ]; then
        echo "Error: This script must be run as root. Exiting."
        exit 1
    fi

    disable_directory_browsing
    restart_apache

    echo "Directory browsing has been disabled successfully."
}

# Execute the main function
main
