Write-Host "Enumerating for trusted delegation..."

$accounts = Get-ADUser -Filter {TrustedForDelegation -eq $true}
Write-Host "'nUSERS WITH DELEGATION TRUST ENABLED: $accounts"

$computers = Get-ADUser -Filter {TrustedForDelegation -eq $true}
Write-Host "'nCOMPUTERS WITH DELEGATION TRUST ENABLED:

Write-Host "Delunumeration complete." -ForeGroundColor Red
