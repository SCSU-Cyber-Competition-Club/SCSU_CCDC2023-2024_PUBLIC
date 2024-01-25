#!/bin/bash

# Check if the script is run with sudo privileges
if [[ "$(id -u)" != "0" ]]; then
    echo "ERROR: The script must be run with sudo privileges!"
    exit 1
fi

# Define backup destination directory
backup_dir="/var/opt"
timestamp=$(date +%Y%m%d_%H%M%S)
backup_filename="full_backup_$timestamp.tar.gz"

# Log file for capturing script output
log_file="/var/log/bac.log"

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

# Print a message indicating the start of the backup
echo "Starting full backup script"
log "Starting full backup script"

# Create backup destination directory if it doesn't exist
mkdir -p "$backup_dir" || handle_error "Failed to create backup directory"

# Use tar to create a compressed archive of the entire filesystem
tar --exclude=/proc --exclude=/sys --exclude=/dev --exclude=/run \
    --exclude=/mnt --exclude=/media --exclude=/lost+found \
    -cvpzf "$backup_dir/$backup_filename" / 2>> "$log_file"

# Check if the backup was successful
if [ $? -eq 0 ]; then
    echo "Full backup completed successfully. Backup file: $backup_dir/$backup_filename"
    log "Full backup completed successfully. Backup file: $backup_dir/$backup_filename"
else
    handle_error "Full backup failed. Check $log_file for details."
fi

exit 0
