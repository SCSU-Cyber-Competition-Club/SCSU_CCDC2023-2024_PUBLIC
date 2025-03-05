# Retrieve all computers with non-null SPNs
Get-ADComputer -Filter * -Property ServicePrincipalName | Where-Object { $_.ServicePrincipalName -ne $null }

# Retrieve all users with non-null SPNs
Get-ADUser -Filter * -Property ServicePrincipalName | Where-Object { $_.ServicePrincipalName -ne $null }

# Retrieve all managed service accounts (MSAs) with non-null SPNs
Get-ADServiceAccount -Filter * -Property ServicePrincipalName | Where-Object { $_.ServicePrincipalName -ne $null }

Write-Host "'nThat's it for SPNs..."
