# Enumerate all Active Directory accounts
$computers = Get-ADComputer -Filter * 
$users = Get-ADUser -Filter *
$msas = Get-ADServiceAccount -Filter *

# Combine all the accounts (computers, users, and MSAs)
$allAccounts = $computers + $users + $msas

# Iterate over the list of accounts
foreach ($account in $allAccounts) {
    # Display the account name
    Write-Host "`nAccount: $($account.Name)"
    
    # Ask the user if they want to change the password
    $response = Read-Host "Do you want to change the password for this account? (yes/no)"
    
    if ($response -eq "yes") {
        # Prompt for the new password
        $newPassword = Read-Host "Enter the new password" -AsSecureString
        
        try {
            # For user accounts, use Set-ADUser to change the password
            if ($account -is [Microsoft.ActiveDirectory.Management.ADUser]) {
                Set-ADUser -Identity $account.DistinguishedName -AccountPassword $newPassword -Reset
                Write-Host "Password changed for user account: $($account.Name)"
            }
            
            # For computer accounts, use Set-ADComputer to change the password
            elseif ($account -is [Microsoft.ActiveDirectory.Management.ADComputer]) {
                Set-ADComputer -Identity $account.DistinguishedName -AccountPassword $newPassword -Reset
                Write-Host "Password changed for computer account: $($account.Name)"
            }
            
            # For Managed Service Accounts (MSAs), use Set-ADServiceAccount to change the password
            elseif ($account -is [Microsoft.ActiveDirectory.Management.ADServiceAccount]) {
                Set-ADServiceAccount -Identity $account.DistinguishedName -AccountPassword $newPassword -Reset
                Write-Host "Password changed for managed service account: $($account.Name)"
            }
        }
        catch {
            Write-Host "Error changing password for account $($account.Name): $_"
        }
    }
    else {
        Write-Host "Password not changed for account: $($account.Name)"
    }
}

Write-Host "`nScript completed."
