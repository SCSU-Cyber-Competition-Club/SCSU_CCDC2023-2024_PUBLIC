# Linux Security and System Administration Guide

## User Management and Authentication

### View all user accounts
cat /etc/passwd         # Show all system users
getent passwd          # Alternative way to list users
cut -d: -f1 /etc/passwd # List only usernames
#### Show users with login shells
grep -E '/bin/(ba)?sh' /etc/passwd

### Password Management
- Change current user password: `passwd`
- Change specific user password: `passwd [username]`

### Root Account Security
> **TODO:** Add alternate user to the sudoers file before locking the root account!

- Lock root account: `sudo passwd -l root`

### SSH Configuration
1. Configure root SSH access:
   ```bash
   sudo nano /etc/ssh/sshd_config
   # Find "PermitRootLogin" and set to "no"
2. 
```
sudo systemctl restart ssh
```

# Check user login history
last                    # Show recent logins
lastlog                 # Display last login for all users
who                     # Show currently logged-in users
w                       # Show who is logged in and what they're doing

# Check failed login attempts
sudo grep "Failed password" /var/log/auth.log