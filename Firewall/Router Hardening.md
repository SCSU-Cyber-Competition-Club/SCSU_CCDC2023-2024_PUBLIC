
# Basic Guide to Hardening a Cisco 2911 Router and Management Interface Access

## 1. **Secure Physical and Console Access**
   - Place the router in a secure, access-controlled environment.
   - Set a strong password for console access:
     ```plaintext
     Router(config)# line console 0
     Router(config-line)# password <STRONG_PASSWORD>
     Router(config-line)# login
     ```

## 2. **Secure Remote Management (Disable Unused Services)**
   - Disable Telnet and enable SSH:
     ```plaintext
     Router(config)# no ip telnet server
     Router(config)# ip domain-name yourdomain.com
     Router(config)# crypto key generate rsa modulus 2048
     Router(config)# ip ssh version 2
     Router(config)# line vty 0 4
     Router(config-line)# transport input ssh
     Router(config-line)# login local
     Router(config-line)# exit
     ```
   - Create a secure local user for SSH access:
     ```plaintext
     Router(config)# username admin privilege 15 secret <STRONG_PASSWORD>
     ```

## 3. **Enable AAA and Role-Based Access Control**
   - Configure AAA authentication:
     ```plaintext
     Router(config)# aaa new-model
     Router(config)# aaa authentication login default local
     ```
   - Use role-based access for different admin levels:
     ```plaintext
     Router(config)# username netadmin privilege 15 secret <STRONG_PASSWORD>
     Router(config)# username helpdesk privilege 5 secret <MEDIUM_PASSWORD>
     ```

## 4. **Secure Management Interfaces**
   - Restrict management access to trusted IPs:
     ```plaintext
     Router(config)# access-list 10 permit <TRUSTED_IP>
     Router(config)# access-list 10 deny any
     Router(config)# line vty 0 4
     Router(config-line)# access-class 10 in
     Router(config-line)# exit
     ```
   - Enable logging for SSH access attempts:
     ```plaintext
     Router(config)# login on-failure log
     Router(config)# login on-success log
     ```

## 5. **Disable Unnecessary Services**
   - Disable unneeded services to reduce attack surface:
     ```plaintext
     Router(config)# no ip http server
     Router(config)# no ip http secure-server
     Router(config)# service tcp-small-servers
     Router(config)# service udp-small-servers
     ```

## 6. **Implement Strong Password Policies**
   - Set minimum password length:
     ```plaintext
     Router(config)# security passwords min-length 12
     ```
   - Enable password encryption:
     ```plaintext
     Router(config)# service password-encryption
     ```

## 7. **Enable Logging and Monitoring**
   - Enable syslog logging:
     ```plaintext
     Router(config)# logging host <SYSLOG_SERVER_IP>
     Router(config)# logging trap informational
     ```
   - Enable timestamps:
     ```plaintext
     Router(config)# service timestamps log datetime msec
     ```

## 8. **Apply Access Control Lists (ACLs)**
   - Restrict traffic to management interfaces:
     ```plaintext
     Router(config)# access-list 100 permit tcp <TRUSTED_IP> any eq 22
     Router(config)# access-list 100 deny ip any any
     Router(config)# interface GigabitEthernet0/0
     Router(config-if)# ip access-group 100 in
     Router(config-if)# exit
     ```

## 9. **Regular Updates and Backup**
   - Regularly update IOS firmware.
   - Schedule automatic configuration backups to a remote server.

## 10. **Enable Security Features**
   - Enable Control Plane Policing (CoPP) to protect against DoS attacks:
     ```plaintext
     Router(config)# policy-map CONTROL-PLANE-POLICY
     Router(config-pmap)# class MANAGEMENT-TRAFFIC
     Router(config-pmap-c)# police 8000 conform-action transmit exceed-action drop
     Router(config-pmap-c)# exit
     Router(config)# control-plane
     Router(config-cp)# service-policy input CONTROL-PLANE-POLICY
     ```

By implementing these steps, your Cisco 2911 router will be significantly more secure against unauthorized access and attacks.
