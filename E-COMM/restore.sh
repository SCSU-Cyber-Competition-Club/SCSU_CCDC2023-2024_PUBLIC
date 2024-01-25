#!/bin/bash

# Check if the script is run with sudo privileges
if [[ "$(id -u)" != "0" ]]; then
    echo "ERROR: The script must be run with sudo privileges!"
    exit 1
fi

# Specify the backup file to restore
backup_dir="/var/opt"
latest_backup=$(ls -t "$backup_dir" | head -n 1)

if [ -z "$latest_backup" ]; then
    echo "ERROR: No backup file found in $backup_dir"
    exit 1
fi

backup_file="$backup_dir/$latest_backup"

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

# Print a message indicating the start of the restore
echo "Starting restore from backup script"
log "Starting restore from backup script"

# Check if the backup file exists
if [ ! -f "$backup_file" ]; then
    handle_error "Backup file $backup_file not found"
fi

# Extract the backup to a temporary directory
temp_dir=$(mktemp -d)
tar -xzf "$backup_file" -C "$temp_dir" 2>> "$log_file"

# Check if the extraction was successful
if [ $? -eq 0 ]; then
    echo "Backup extracted successfully to $temp_dir"
    log "Backup extracted successfully to $temp_dir"
else
    handle_error "Failed to extract backup. Check $log_file for details."
fi

# Restore files from the temporary directory to their original locations
cp -R "$temp_dir"/* /

# Check if the restore was successful
if [ $? -eq 0 ]; then
    echo "Restore completed successfully"
    log "Restore completed successfully"
else
    handle_error "Restore failed. Check $log_file for details."
fi

# Cleanup temporary directory
rm -r "$temp_dir"

exit 0
