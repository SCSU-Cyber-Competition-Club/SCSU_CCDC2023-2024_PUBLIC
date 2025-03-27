# Allowing an account to not require pre-authorization allows attackers to easily obtain the password hash of an account early
# in the Kerberos authentication process through AS-REP roasting, which can be cracked offline.

#Find all accounts who don't require pre-authentication; pipe these accounts into a command making them require it.
Write-Host "Dealing with no-pre-auth accounts..." -ForeGroundColor Red
 
 Get-ADUSer -Filter 'DoesNotRequirePreAuth -eq $true ' | Set-ADAccountControl -doesnotrequirepreauth $false
 Get-ADComputer -Filter 'DoesNotRequirePreAuth -eq $true ' | Set-ADAccountControl -doesnotrequirepreauth $false
# Get-ADUSer -Filter 'DoesNotRequirePreAuth -eq $true ' | Set-ADAccountControl -doesnotrequirepreauth $false
 Write-Host "All preauthentication has been purged." -ForeGroundColor Red
