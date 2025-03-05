#!/bin/bash

# Log file locations - using absolute paths
LOG_FILE="/var/log/security_monitoring.log"
LAST_CHECK_FILE="/var/log/last_check_time"
PREVIOUS_EVENTS_FILE="/var/log/previous_events.hash"
SUID_FILE="/var/log/suid_files.list"

# Determine the auth log file based on the system
if [ -f "/var/log/auth.log" ]; then
    AUTH_LOG="/var/log/auth.log"
elif [ -f "/var/log/secure" ]; then
    AUTH_LOG="/var/log/secure"
else
    echo "Could not find authentication log file"
    exit 1
fi

# Function to send notifications
notify_user() {
    local title="$1"
    local message="$2"
    local urgency="$3"  # can be "low", "normal", or "critical"
    local event_hash=$(echo "$title$message" | md5sum | cut -d' ' -f1)
    
    # Check if this event was already reported
    if [ -f "$PREVIOUS_EVENTS_FILE" ] && grep -q "$event_hash" "$PREVIOUS_EVENTS_FILE"; then
        return
    fi
    
    # Print to terminal
    echo -e "\n[$(date '+%Y-%m-%d %H:%M:%S')] === $title ===\n$message"

    # Send notification to all logged-in users using wall
    echo -e "\n=== Security Alert ===\n$title\n$message" | wall

    # Try desktop notification for all users with active displays
    for user in $(who | cut -d' ' -f1 | sort | uniq); do
        for display in $(ps e -u "$user" | grep -o 'DISPLAY=:[0-9]*' | sort | uniq | cut -d'=' -f2); do
            DISPLAY="$display" sudo -u "$user" notify-send --urgency="$urgency" "$title" "$message" 2>/dev/null || true
        done
    done

    # Store the event hash
    echo "$event_hash" >> "$PREVIOUS_EVENTS_FILE"
    
    # Keep only last 1000 events in the hash file
    if [ -f "$PREVIOUS_EVENTS_FILE" ]; then
        tail -n 1000 "$PREVIOUS_EVENTS_FILE" > "$PREVIOUS_EVENTS_FILE.tmp"
        mv "$PREVIOUS_EVENTS_FILE.tmp" "$PREVIOUS_EVENTS_FILE"
    fi
}

# Function to log messages
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
    notify_user "Security Alert" "$1" "normal"
}

# Initialize files if they don't exist
if [ ! -f "$LAST_CHECK_FILE" ]; then
    date +%s > "$LAST_CHECK_FILE"
fi

if [ ! -f "$PREVIOUS_EVENTS_FILE" ]; then
    touch "$PREVIOUS_EVENTS_FILE"
fi

# Function to monitor auth.log for new user accounts and group changes
monitor_auth_log() {
    local last_check=$(cat "$LAST_CHECK_FILE")
    local new_entries
    
    # Check for new user additions
    new_entries=$(grep "useradd\|adduser" "$AUTH_LOG" | awk -v last_check="$last_check" '{ if ($1$2$3 > last_check) print $0 }')
    if [ ! -z "$new_entries" ]; then
        notify_user "New User Account(s) Detected" "$new_entries" "critical"
        log_message "New user account(s) detected:"
        echo "$new_entries" >> "$LOG_FILE"
    fi
    
    # Check for group modifications
    new_entries=$(grep "groupadd\|groupmod\|usermod" "$AUTH_LOG" | awk -v last_check="$last_check" '{ if ($1$2$3 > last_check) print $0 }')
    if [ ! -z "$new_entries" ]; then
        notify_user "Group Modification(s) Detected" "$new_entries" "critical"
        log_message "Group modification(s) detected:"
        echo "$new_entries" >> "$LOG_FILE"
    fi

    # Check for password changes
    new_entries=$(grep "passwd\|password changed" "$AUTH_LOG" | awk -v last_check="$last_check" '{ if ($1$2$3 > last_check) print $0 }')
    if [ ! -z "$new_entries" ]; then
        notify_user "Password Change(s) Detected" "$new_entries" "critical"
        log_message "Password change(s) detected:"
        echo "$new_entries" >> "$LOG_FILE"
    fi

    # Check for login attempts (both successful and failed)
    new_entries=$(grep "session opened\|Failed password\|authentication failure" "$AUTH_LOG" | awk -v last_check="$last_check" '{ if ($1$2$3 > last_check) print $0 }')
    if [ ! -z "$new_entries" ]; then
        # All login activity is now critical
        notify_user "Login Activity Detected" "$new_entries" "critical"
        log_message "Login activity detected:"
        echo "$new_entries" >> "$LOG_FILE"
    fi
}

# Function to monitor syslog for important system changes
monitor_syslog() {
    local last_check=$(cat "$LAST_CHECK_FILE")
    local new_entries
    
    new_entries=$(grep -i "security\|authentication\|error" /var/log/syslog | awk -v last_check="$last_check" '{ if ($1$2$3 > last_check) print $0 }')
    if [ ! -z "$new_entries" ]; then
        notify_user "Important System Events" "$new_entries" "normal"
        log_message "Important system events detected:"
        echo "$new_entries" >> "$LOG_FILE"
    fi
}

# Function to check for SUID changes
monitor_suid_changes() {
    # Create initial SUID file list if it doesn't exist
    if [ ! -f "$SUID_FILE" ]; then
        find / -type f -perm -4000 -ls 2>/dev/null > "$SUID_FILE"
        notify_user "SUID Monitoring" "Initial SUID file list created" "low"
        log_message "Initial SUID file list created"
        return
    fi
    
    # Create temporary file for current SUID files
    TEMP_SUID="/tmp/suid_files.tmp"
    find / -type f -perm -4000 -ls 2>/dev/null > "$TEMP_SUID"
    
    # Compare with previous list
    diff "$SUID_FILE" "$TEMP_SUID" > /dev/null
    if [ $? -ne 0 ]; then
        local diff_output=$(diff "$SUID_FILE" "$TEMP_SUID")
        notify_user "SUID Permission Changes" "$diff_output" "critical"
        log_message "SUID permission changes detected:"
        echo "$diff_output" >> "$LOG_FILE"
        # Update the SUID file list
        mv "$TEMP_SUID" "$SUID_FILE"
    else
        rm "$TEMP_SUID"
    fi
}

# Function to monitor HTTP service status
monitor_httpd() {
    if ! systemctl is-active --quiet apache2 && ! systemctl is-active --quiet httpd; then
        local message="ALERT: HTTP service (apache2/httpd) is not running!"
        
        # Check service logs for reason
        if [ -f "/var/log/apache2/error.log" ]; then
            local error_log="/var/log/apache2/error.log"
        elif [ -f "/var/log/httpd/error_log" ]; then
            local error_log="/var/log/httpd/error_log"
        fi
        
        if [ ! -z "$error_log" ]; then
            local last_errors=$(tail -n 5 "$error_log")
            message+="\n\nLast HTTP service errors:\n$last_errors"
        fi
        
        notify_user "HTTP Service Down" "$message" "critical"
        log_message "$message"
    fi
}

# Run all monitoring functions
monitor_auth_log
monitor_syslog
monitor_suid_changes
monitor_httpd

# Update last check time
date +%s > "$LAST_CHECK_FILE"
