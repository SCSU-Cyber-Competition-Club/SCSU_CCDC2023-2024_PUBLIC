
## HTTP
A request for a specific web page will be made. Once the request is made, the
result will be stored in a file and compared to the expected result. The returned
page must match the expected content for points to be awarded.
## HTTPS
A request for a page over SSL will be made. Again, the request will be made,
the result stored in a file, and the result compared to the expected result. The
returned page needs to match the expected file for points to be awarded.
## SMTP
Email will be sent and received through a valid email account via SMTP. This
will simulate an employee in the field using their email. Each successful test of
email functionality will be awarded points.
## DNS
DNS lookups will be performed against the DNS server. Each successfully
served request will be awarded points.
## POP3
POP3 connections will be performed against the system using usernames from
Active Directory. Once connected a series of commands will be run and the
output examined. Correct responses will be awarded points.
## FTP
Access to the FTP service either via authentication or anonymous will be made,
and the presence of various files will be checked.
## TFTP
Access to the tftp service will be made to pull down a small file with an integrity
check.
## NTP
Access to the ntp service will be made to assure time integrity