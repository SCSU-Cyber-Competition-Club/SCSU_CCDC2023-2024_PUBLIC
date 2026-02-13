
| **Port** | **Protocol/Service** | **Default Usage**                                          | **TCP/UDP** |
| -------- | -------------------- | ---------------------------------------------------------- | ----------- |
| 80       | HTTP                 | Accessing the PrestaShop frontend/backoffice (unencrypted) | TCP         |
| 443      | HTTPS                | Accessing the PrestaShop frontend/backoffice (encrypted)   | TCP         |
| 3306     | MySQL/MariaDB        | Database connection for PrestaShop                         | TCP         |
| 22       | SSH                  | Secure shell access to the Apache server                   | TCP         |
| 21       | FTP                  | File transfers to/from the Apache server                   | TCP         |
| 990      | FTPS                 | Secure file transfers to/from the Apache server            | TCP         |
| 8080     | Alternate HTTP       | Alternative HTTP port (if configured in Apache)            | TCP         |
| 8443     | Alternate HTTPS      | Alternative HTTPS port (if configured in Apache)           | TCP         |
