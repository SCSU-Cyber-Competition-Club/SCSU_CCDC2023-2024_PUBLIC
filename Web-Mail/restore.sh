#!/bin/bash

# Check if the script is run with sudo privileges
if [[ "$(id -u)" != "0" ]]; then
    echo "ERROR: The script must be run with sudo privileges!"
    exit 1
fi

# Stop Services

list=(
    "crond.service"
    "dovecot.service"
    "httpd.service"
    "mariadb.service"
    "postfix.service"
    "sshd.service"
)
for i in "${list[@]}"; do
	systemctl stop "$i"
done

# Print a message indicating the start of the restore

echo "Starting restore from backup script"

# Specify the backup file to restore

backup_fld=(
    "/var/lib/mysql"
    "/var/lib/dovecot"
    "/var/lib/php"
    "/var/lib/mysql"
    "/var/lib/postfix"
    "/var/lib/roundcubemail"
)
for i in "${backup_fld[@]}"; do
	cp -R "/opt/bak/cfg$i/." "$i/"
done


backup_fld2=(
    "/etc/httpd"
    "/etc/ssmtp"
    "/etc/roundcubemail"
    "/etc/postfix"
    "/etc/dovecot"
)
for i in "${backup_fld2[@]}"; do
	cp -R "/opt/bak/cfg$i/." "$i/"
done


# Log file for capturing script output
log_file="/var/log/restore.log"

# Function to log messages

log() {
    local log_message="$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') $log_message" >> "$log_file"
}

# Function to handle errors

handle_error() {
    local error_message="$1"
    echo "ERROR: $error_message"
    log "ERROR: $error_message"
    exit 1
}

# Restart Services

for i in "${list[@]}"; do
	systemctl restart "$i"
done

# Check if the restore was successful

if [ $? -eq 0 ]; then
    echo "Restore completed successfully"
    log "Restore completed successfully"
else
    handle_error "Restore failed. Check $log_file for details."
fi


exit 0
