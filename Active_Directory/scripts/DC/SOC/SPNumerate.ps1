# Service Principal Names (SPNs) are used to associate a service instance with a service account. In other words,
#accounts with SPNs have access to the service relevant to that SPN. Knowledge of the SPNs present in your environment
#is important for understanding your attack surface; finding an SPN for a service you really don't want compromised
#on a low-privilege user account (or any account weakly protected) is something that needs to be remedied.

#If we assume the competition doesn't change, there will be no unnecessary/misplaced SPNs, however.
Write-Host "Initiating SPNumeration..." -ForeGroundColor Red
 # Retrieve all computers with non-null SPNs
Get-ADComputer -Filter * -Property ServicePrincipalName | Where-Object { $_.ServicePrincipalName -ne $null }

# Retrieve all users with non-null SPNs
Get-ADUser -Filter * -Property ServicePrincipalName | Where-Object { $_.ServicePrincipalName -ne $null }

# Retrieve all managed service accounts (MSAs) with non-null SPNs
Get-ADServiceAccount -Filter * -Property ServicePrincipalName | Where-Object { $_.ServicePrincipalName -ne $null }

Write-Host "SPNumeration complete." -ForeGroundColor Red
