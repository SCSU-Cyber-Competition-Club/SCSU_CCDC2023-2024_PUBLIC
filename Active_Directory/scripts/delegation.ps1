Write-Host "Enumerating for trusted delegation..." -ForeGroundColor Red

$accounts = Get-ADUser -Filter {TrustedForDelegation -eq $true}
Write-Host "USERS WITH DELEGATION TRUST ENABLED: $accounts"

$computers = Get-ADComputer -Filter {TrustedForDelegation -eq $true}
Write-Host "COMPUTERS WITH DELEGATION TRUST ENABLED: $computers"

Write-Host "Delunumeration complete." -ForeGroundColor Red
