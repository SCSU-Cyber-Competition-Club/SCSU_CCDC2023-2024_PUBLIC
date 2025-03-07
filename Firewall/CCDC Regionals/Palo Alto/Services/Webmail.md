| **Port** | **Protocol/Service**      | **Default Usage**                                   | **TCP/UDP** |
| -------- | ------------------------- | --------------------------------------------------- | ----------- |
| 80       | HTTP                      | Accessing the Roundcube web interface (unencrypted) | TCP         |
| 443      | HTTPS                     | Accessing the Roundcube web interface (encrypted)   | TCP         |
| 143      | IMAP                      | Fetching emails from the mail server                | TCP         |
| 993      | IMAPS (IMAP over SSL/TLS) | Securely fetching emails from the mail server       | TCP         |
| 25       | SMTP                      | Sending emails (unencrypted, legacy use)            | TCP         |
| 465      | SMTPS (SMTP over SSL)     | Securely sending emails                             | TCP         |
| 587      | SMTP with STARTTLS        | Sending emails with encryption (recommended)        | TCP         |
| 389      | LDAP                      | Authenticating users against AD directory services  | TCP/UDP     |
| 636      | LDAPS (LDAP over SSL/TLS) | Secure LDAP authentication                          | TCP         |
| 88       | Kerberos                  | Authenticating users (used for Single Sign-On)      | TCP/UDP     |
| 53       | DNS                       | Resolving domain names in the AD environment        | TCP/UDP     |
| 123      | NTP                       | Time synchronization (required for Kerberos)        | UDP         |
| 445      | SMB                       | Accessing AD-related resources, including GPOs      | TCP         |
| 110      | POP3                      |                                                     | TCP         |
| 995      | POP3 (POP3 over SSL/TLS)  |                                                     | TCP         |
