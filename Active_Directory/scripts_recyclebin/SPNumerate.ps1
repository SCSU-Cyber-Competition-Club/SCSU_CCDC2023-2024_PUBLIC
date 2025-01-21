# Retrieve all computers with non-null SPNs
$computers = Get-ADComputer -Filter * -Property ServicePrincipalName | Where-Object { $_.ServicePrincipalName -ne $null }

# Retrieve all users with non-null SPNs
$users = Get-ADUser -Filter * -Property ServicePrincipalName | Where-Object { $_.ServicePrincipalName -ne $null }

# Retrieve all managed service accounts (MSAs) with non-null SPNs
$msas = Get-ADServiceAccount -Filter * -Property ServicePrincipalName | Where-Object { $_.ServicePrincipalName -ne $null }

# Combine all objects (computers, users, and MSAs) into one list
$accountsWithSPNs = $computers + $users + $msas

# Iterate over each account with an SPN and ask the user if they want to disable the SPN
foreach ($account in $accountsWithSPNs) {
    # Display the account name and SPN(s)
    Write-Host "`nAccount: $($account.Name)"
    Write-Host "ServicePrincipalName(s): $($account.ServicePrincipalName)"
    
    # Ask the user if they want to disable the SPN
    $response = Read-Host "Do you want to disable the SPN for this account? (yes/no)"
    
    # If the user responds 'yes', clear the ServicePrincipalName
    if ($response -eq "yes") {
        # Disable the SPN (clear the ServicePrincipalName)
        Set-ADObject -Identity $account.DistinguishedName -Clear ServicePrincipalName
        Write-Host "SPN disabled for account: $($account.Name)"
    } else {
        Write-Host "SPN not disabled for account: $($account.Name)"
    }
}

Write-Host "`nScript completed."

