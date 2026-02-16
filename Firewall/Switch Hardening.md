
## 1. Enable SSH (Disable Telnet)
```bash
conf t
hostname SW1
ip domain-name example.com
crypto key generate rsa modulus 2048
ip ssh version 2
```

## 2. Create a Secure User for SSH Access
```bash
username admin privilege 15 secret StrongPassword
```

## 3. Restrict VTY Lines to SSH Only
```bash
line vty 0 4
transport input ssh
login local
exec-timeout 5 0
```

## 4. Apply an ACL to Restrict SSH Access
```bash
ip access-list standard SSH_ACCESS
permit 192.168.1.0 0.0.0.255
exit
line vty 0 4
access-class SSH_ACCESS in
```

## 5. Disable Unused Management Interfaces
```bash
interface vlan 1
shutdown
```

## 6. Secure Console Access
```bash
line con 0
exec-timeout 5 0
logging synchronous
login local
```

## 7. Enable Logging & Monitor Failed Login Attempts
```bash
login block-for 120 attempts 3 within 60
exit
copy Running-config Startup-config
```