# Enumerate all Active Directory accounts
$computers = Get-ADComputer -Filter * 
$users = Get-ADUser -Filter *
$msas = Get-ADServiceAccount -Filter *

$killcount = 0 #very important variable.

# Combine all the accounts (computers, users, and MSAs)
$allAccounts = $computers + $users + $msas

# Iterate over the list of accounts
foreach ($account in $allAccounts) {
    # Display the account name
    Write-Host "`nAccount: $($account.Name)"
    
    # Ask the user if they want to delete the account
    $response = Read-Host "Do you want to delete this account? (yes/no)"
    
    if ($response -eq "yes") {
        try {
            # For user accounts, use Remove-ADUser to delete the account
            if ($account -is [Microsoft.ActiveDirectory.Management.ADUser]) {
                Remove-ADUser -Identity $account.DistinguishedName -Confirm:$false
                Write-Host "User $($account.Name) has been slain." -ForeGroundColor Red
                $killcount++
            }
            
            # For computer accounts, use Remove-ADComputer to delete the account
            elseif ($account -is [Microsoft.ActiveDirectory.Management.ADComputer]) {
                Remove-ADComputer -Identity $account.DistinguishedName -Confirm:$false
                Write-Host "Computer $($account.Name) has been slain." -ForeGroundColor Red
                $killcount++
            }
            
            # For Managed Service Accounts (MSAs), use Remove-ADServiceAccount to delete the account
            elseif ($account -is [Microsoft.ActiveDirectory.Management.ADServiceAccount]) {
                Remove-ADServiceAccount -Identity $account.DistinguishedName -Confirm:$false
                Write-Host "Managed service account $($account.Name) has been slain."
                $killcount++
            }
        }
        catch {
            Write-Host "Error deleting account $($account.Name): $_"
        }
    }
    else {
        Write-Host "Account not deleted: $($account.Name)"
    }
}

Write-Host "`nScript completed."
if ($killcount -eq 0) {
Write-Host "Pacifist run complete. No accounts were disabled. Coward."
}
elseif ($killcount -le 3) {
Write-Host "Script complete. $killcount enemies slain. Rookie numbers, kiddo."
}
else {
Write-Host "Script complete. You killed $killcount people today. The FBI would officially classify you as a mass murderer. Put that on the resume!"
}