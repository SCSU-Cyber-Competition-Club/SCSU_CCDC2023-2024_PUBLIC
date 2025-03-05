Write-Host "Disabling LLMNR..." -ForeGroundColor Red

Set-GPRegistryValue -Name "DisableLLMNR" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" -ValueName "EnableMulticast" -Value 0 -Type DWord
Write-Host "LLMNR disabled. Vaccination complete."

Write-Host "LLMNR disabled." -ForeGroundColor Red
