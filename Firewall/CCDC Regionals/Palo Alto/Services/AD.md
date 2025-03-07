
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
