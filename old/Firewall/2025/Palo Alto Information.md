
| System Name | OS            | IP Address     | Username | Password    |
| ----------- | ------------- | -------------- | -------- | ----------- |
| Palo Alto   | PAN OS 11.0.0 | 172.20.242.150 | admin    | Changeme123 |

## Interfaces

| Interface | IP Address        | Comment  | Computer                     | Zone     |
| --------- | ----------------- | -------- | ---------------------------- | -------- |
| eth 1/1   | 17.20.241.254/25  | PUBLIC   | Splunk, E-comm, Webmail      | Public   |
| eth 1/2   | 172.20.240.254/24 | INTERNAL | Docker, Debian(BIND)         | Internal |
| eht 1/3   | 172.31.21.2/29    | EXTERNAL | Internet, Windows 10         | External |
| eth 1/4   | 172.20.242.254/24 | USER     | Ubuntu Web, AD, Unbuntu Wkst | User     |

## DHCP

| Interface | Pool               | DNS                          | Gateway        | Lease | Zone     |
| --------- | ------------------ | ---------------------------- | -------------- | ----- | -------- |
| eth 1/1   | 172.20.241.101-150 | N/A                          | 172.20.241.254 | 1 day | Public   |
| eth 1/2   | 172.20.240.101-150 | N/A                          | 172.20.240.254 | 1 day | Internal |
| eth 1/4   | 172.20.242.101-150 | 172.20.241.27, 172.20.240.23 | 172.20.242.254 | 1 day | User     |
## NAT

| Name           | Source Zone | Source Address | Destination Address |
| -------------- | ----------- | -------------- | ------------------- |
| PA             | User        | 172.20.242.150 | 172.25.21.150       |
| User NAT       | User        | 172.20.242.254 | 172.25.21.152       |
| Public NAT     | Public      | 172.20.241.254 | 172.25.21.151       |
| Internal NAT   | Internal    | 172.20.240.254 | 172.25.21.150       |
| CentOS e-comm  | Public      | 172.20.241.30  | 172.25.21.11        |
| Ubuntu Srv     | User        | 172.20.242.10  | 172.25.21.23        |
| Splunk         | Public      | 172.20.241.20  | 172.25.21.9         |
| Fedora webmail | Public      | 172.20.241.40  | 172.25.21.39        |
| 2012 AD-DNS    | User        | 172.20.242.200 | 172.25.21.27        |
| 2016           | Internal    | 172.20.240.10  | 172.25.21.97        |
| Debian DNS     | Internal    | 172.20.240.20  | 172.25.21.20        |

