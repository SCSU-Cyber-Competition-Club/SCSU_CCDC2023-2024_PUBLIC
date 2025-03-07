### DNS
| **Port** | **Protocol/Service** | **Default Usage**                              | **TCP/UDP** |
| -------- | -------------------- | ---------------------------------------------- | ----------- |
| 53       | DNS                  | Domain name resolution (queries and responses) | TCP/UDP     |
| 853      | DNS over TLS (DoT)   | Secure DNS resolution using TLS                | TCP         |
| 5353     | Multicast DNS (mDNS) | Local network name resolution (zero-config)    | UDP         |
| 443      | DNS over HTTPS (DoH) | Secure DNS resolution over HTTPS               | TCP         |

## AD
| **Port**    | **Protocol/Service**     | **Default Usage**                                       | **TCP/UDP** |
| ----------- | ------------------------ | ------------------------------------------------------- | ----------- |
| 389         | LDAP                     | Directory services (query and modify AD data)           | TCP/UDP     |
| 636         | LDAPS                    | Secure LDAP (LDAP over SSL/TLS)                         | TCP         |
| 3268        | Global Catalog (LDAP)    | Queries across multiple domains in the AD forest        | TCP         |
| 3269        | Global Catalog (LDAPS)   | Secure Global Catalog queries                           | TCP         |
| 88          | Kerberos                 | Authentication protocol                                 | TCP/UDP     |
| 445         | SMB                      | File sharing, authentication, Group Policy application  | TCP         |
| 464         | Kerberos Password Change | Changing user passwords                                 | TCP/UDP     |
| 53          | DNS                      | Resolving domain names (essential for AD functionality) | TCP/UDP     |
| 135         | RPC Endpoint Mapper      | Used for locating DCOM services                         | TCP/UDP     |
| 49152-65535 | Dynamic RPC Ports        | Range used for RPC communication (configurable)         | TCP         |
| 123         | NTP                      | Time synchronization (required for Kerberos)            | UDP         |
| 25          | SMTP                     | Email delivery for AD-integrated Exchange environments  | TCP         |


## Splunk

| Port | Protocol                   | Usage                                                 | TCP/UDP |
| ---- | -------------------------- | ----------------------------------------------------- | ------- |
| 9997 | Splunk Forwarding          | Data forwarding from Universal Forwarders to Indexers | TCP     |
| 8089 | Splunk Management          | Management traffic (e.g., REST API communication)     | TCP     |
| 8000 | Web Interface              | Splunk Web interface for administrators               | TCP     |
| 514  | Syslog Input               | Receiving Syslog data (can be configured for both)    | TCP/UDP |
| 8088 | HTTP Event Collector (HEC) | Receiving data via HTTP/HTTPS                         | TCP     |
| 8191 | Inter-Splunk Communication | Splunk-to-Splunk communication in clusters            | TCP     |
## NTP

| Port | Protocol | Usage                              | TCP/UDP |
| ---- | -------- | ---------------------------------- | ------- |
| 123  | NTP      | Synchronizing time between systems | UDP     |

## WebMail/WebApps
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
