#This is just going to disable TrustedForDelegation for user accounts, for now. Worried about breaking services if doing so for system accounts.
$accounts = Get-ADUser -Filter {TrustedForDelegation -eq $true}
Write-Host "Accounts with TrustedForDelegation enabled: $accounts"

foreach ($account in $accounts) {
Set-ADComputer -Identity "$account" -TrustedForDelegation $false
}

Write-Host "Delegation trust disabling complete."