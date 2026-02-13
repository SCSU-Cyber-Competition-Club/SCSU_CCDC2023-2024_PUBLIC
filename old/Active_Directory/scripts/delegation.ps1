## Delegation allows a user or computer to impersonate a user when they connect to it (e.g. the Kerberos service account,
##krbtgt, has this enabled so it can impersonate you when interacting with services after you authenticate to the krbtgt account). 
##Again, while this is needed for some functionality like with Kerberos, vulnerabilities in this regard can be summed up as two things:
## 1. Having it enabled on accounts that don't need it, and
## 2. Having it enabled as UNCONSTRAINED delegation. This allows it to impersonate you for use with any service;
## Delegation should be RESTRICTED to only the required functionality.

## If the environment doesn't change, no vulnerabilities with this are present. All required delegation is properly configured.
Write-Host "Enumerating for trusted delegation..." -ForeGroundColor Red

$accounts = Get-ADUser -Filter {TrustedForDelegation -eq $true}
Write-Host "USERS WITH DELEGATION TRUST ENABLED: $accounts"

$computers = Get-ADComputer -Filter {TrustedForDelegation -eq $true}
Write-Host "COMPUTERS WITH DELEGATION TRUST ENABLED: $computers"

Write-Host "Delunumeration complete." -ForeGroundColor Red
