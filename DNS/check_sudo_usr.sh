#!/bin/bash

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root"
    exit 1
fi

echo "Users with sudo privileges on CentOS:"
echo "-----------------------------------"

# Check wheel group members (CentOS default sudo group)
echo "Users in wheel group:"
getent group wheel | cut -d: -f4 | tr ',' '\n'

# List users from /etc/sudoers
echo -e "\nFrom /etc/sudoers:"
grep -E '^[^#].*ALL=\((ALL|ALL:ALL)\)' /etc/sudoers | cut -d' ' -f1

# List users from sudoers.d directory
echo -e "\nFrom /etc/sudoers.d/:"
for file in /etc/sudoers.d/*; do
    if [ -f "$file" ] && [ "$file" != "/etc/sudoers.d/README" ]; then
        echo "File: $file"
        grep -E '^[^#].*ALL=\((ALL|ALL:ALL)\)' "$file" | cut -d' ' -f1
    fi
done

# Additional check for direct sudo permissions
echo -e "\nUsers with direct sudo access:"
for user in $(cut -d: -f1 /etc/passwd); do
    if sudo -l -U "$user" 2>/dev/null | grep -q "may run"; then
        echo "$user"
    fi
done

# Common CentOS sudo configurations
echo -e "\nCommon CentOS sudo configuration files:"
echo "----------------------------------------"
ls -la /etc/sudoers
ls -la /etc/sudoers.d/

# Show current sudoers file content (commented lines removed)
echo -e "\nActive sudoers configurations (non-commented lines):"
echo "---------------------------------------------------"
grep -v '^#' /etc/sudoers | grep -v '^$'
