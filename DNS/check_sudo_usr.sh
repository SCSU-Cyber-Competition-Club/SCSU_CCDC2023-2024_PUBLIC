#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

echo "Users with sudo privileges:"
echo "-------------------------"

# List users from /etc/sudoers
echo "From /etc/sudoers:"
grep -E '^[^#].*ALL=\(ALL(:[A-Z]+)?\)' /etc/sudoers | cut -d' ' -f1

# List users from sudoers.d directory
echo -e "\nFrom /etc/sudoers.d/:"
for file in /etc/sudoers.d/*; do
    if [ -f "$file" ] && [ "$file" != "/etc/sudoers.d/README" ]; then
        grep -E '^[^#].*ALL=\(ALL(:[A-Z]+)?\)' "$file" | cut -d' ' -f1
    fi
done

# List users in sudo group
echo -e "\nUsers in sudo group:"
getent group sudo | cut -d: -f4 | tr ',' '\n'
