#!/bin/bash

echo "=== SSH Security Audit ==="
echo "Press [Enter] to begin the audit..."
read -p ""

# List all user accounts with SSH access
echo -e "\nUsers with SSH access (users with shell access):"
grep -v '/nologin\|/false' /etc/passwd | cut -d: -f1
read -p $'\nPress [Enter] to continue to authorized SSH keys...'

# List all authorized SSH keys for all users
echo -e "\nAuthorized SSH keys for all users:"
for user in $(cut -d: -f1 /etc/passwd); do
    if [ -f "/home/$user/.ssh/authorized_keys" ]; then
        echo -e "\nKeys for user: $user"
        cat "/home/$user/.ssh/authorized_keys"
    fi
done
read -p $'\nPress [Enter] to continue to root SSH access check...'

# Check for root SSH access
echo -e "\nRoot SSH access status:"
if grep -q "^PermitRootLogin" /etc/ssh/sshd_config; then
    grep "^PermitRootLogin" /etc/ssh/sshd_config
else
    echo "PermitRootLogin not explicitly set in sshd_config"
fi
read -p $'\nPress [Enter] to continue to SSH host keys...'

# List SSH host keys
echo -e "\nSSH Host Keys:"
ls -l /etc/ssh/ssh_host_*
read -p $'\nPress [Enter] to continue to SSH configuration...'

# Check SSH configuration
echo -e "\nSSH Configuration Issues:"
sshd -T | grep -E 'passwordauthentication|permitrootlogin|x11forwarding|maxauthtries'
read -p $'\nPress [Enter] to continue to Fail2Ban setup...'

# Install and Configure Fail2Ban
echo -e "\nSetting up Fail2Ban..."
if ! rpm -q fail2ban > /dev/null; then
    echo "Installing Fail2Ban and dependencies..."
    yum install -y epel-release
    yum install -y fail2ban fail2ban-systemd
    
    # Create backup of original config
    if [ ! -f /etc/fail2ban/jail.local ]; then
        cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
    fi
    
    # Configure Fail2Ban
    echo "Configuring Fail2Ban..."
    cat > /etc/fail2ban/jail.local << EOF
[DEFAULT]
bantime = 3600
findtime = 600
maxretry = 5
banaction = iptables-multiport

[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/secure
maxretry = 3
EOF

    # Start and enable Fail2Ban
    systemctl enable fail2ban
    systemctl start fail2ban
    echo "Fail2Ban installation and configuration completed."
else
    echo "Fail2Ban is already installed."
fi
read -p $'\nPress [Enter] to check Fail2Ban status...'

# Display Fail2Ban Status
echo -e "\nFail2Ban Status:"
echo "----------------"
echo -e "\nService Status:"
systemctl status fail2ban
echo -e "\nJail Status:"
fail2ban-client status
echo -e "\nSSH Jail Details:"
fail2ban-client status sshd
echo -e "\nCurrent Fail2Ban Configuration:"
echo "--------------------------------"
cat /etc/fail2ban/jail.local
read -p $'\nPress [Enter] to finish SSH setup...' 