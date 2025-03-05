#This is just going to disable TrustedForDelegation for user accounts, for now. Worried about breaking services if doing so for system accounts.
$accounts = Get-ADUser -Filter {TrustedForDelegation -eq $true}
Write-Host "'nUSERS WITH DELEGATION TRUST ENABLED: $accounts"

$computers = Get-ADUser -Filter {TrustedForDelegation -eq $true}
Write-Host "'nCOMPUTERS WITH DELEGATION TRUST ENABLED:

Write-Host "'nDelegation enumeration complete. (If the competition has you stressed, go ahead and say that five times fast.)"
