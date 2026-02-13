

| Rule # | Source Zone       | Source Address  | Destination Zone  | Destination Address | Service(s)    | Action   |
|-------|-------------------|-----------------|-------------------|---------------------|---------------|----------|
| 1     | Internet (eth1/3)  | Any             | Internal (eth1/2)        | Windows 10 PC       | Any           | Allow    |
| 2     | Internal (eth1/2)        | Any             | Internet (eth1/3)  | Any                 | Any           | Allow    |
| 3     | Internal (eth1/2)        | Any             | User (eth1/4)   | Any                 | Any           | Allow    |
| 4     | User (eth1/4)   | Any             | Internal (eth1/2)        | Any                 | Any           | Allow    |
| 5     | User (eth1/4)   | Any             | Public (eth1/1)     | Any                 | Any           | Allow    |
| 6     | Public (eth1/1)     | Any             | User (eth1/4)   | Any                 | Any           | Allow    |
| 7     | Public (eth1/1)     | Any             | Internal (eth1/2)        | Any                 | Any           | Allow    |
| 8     | Internal (eth1/2)        | DNS/ntp Server  | Internet (eth1/3)  | Any                 | DNS, NTP      | Allow    |
| 9     | User (eth1/4)   | DNS Server      | Internet (eth1/3)  | Any                 | DNS           | Allow    |
| 11    | Public (eth1/1)     | Splunk Server   | Internet (eth1/3)  | Any                 | Splunk        | Allow    |
| 12    | Public (eth1/1)     | E-commerce      | Internet (eth1/3)  | Any                 | HTTP, HTTPS   | Allow    |
| 13    | Public (eth1/1)     | E-commerce      | Internet (eth1/3)  | Any                 | SMTP, POP3    | Allow    |
| 14    | Public (eth1/1)     | Fedora          | Internet (eth1/3)  | Any                 | HTTP, HTTPS   | Allow    |
| 15    | User (eth1/4)   | Ubuntu Web      | Internet (eth1/3)  | Any                 | HTTP, HTTPS   | Allow    |
| 16    | User (eth1/4)   | Windows Server  | Internet (eth1/3)  | Any                 | DNS           | Allow    |
| 17    | User (eth1/4)   | Ubuntu Workstation | Internet (eth1/3) | Any              | Any           | Allow    |
| 18    | Internet (eth1/3)  | Any             | Public (eth1/1)     | Any                 | Any           | Deny     |
| 19    | Internet (eth1/3)  | Any             | Internal (eth1/2)        | Any                 | Any           | Deny     |
| 20    | Internet (eth1/3)  | Any             | User (eth1/4)   | Any                 | Any           | Deny     |
