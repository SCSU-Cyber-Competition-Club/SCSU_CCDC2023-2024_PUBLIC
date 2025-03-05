Write-Host "Dealing with no-pre-auth users..." -ForeGroundColor Red
 Get-ADUSer -Filter 'DoesNotRequirePreAuth -eq $true ' | Set-ADAccountControl -doesnotrequirepreauth $false
 Write-Host "All preauthentication has been purged." -ForeGroundColor Red
