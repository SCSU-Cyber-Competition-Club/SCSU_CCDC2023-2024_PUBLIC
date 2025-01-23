Get-NetAdapter
$response = Read-Host "Which of the above interfaces will be be disabling NBT-NS for?"
Set-NetIPInterface -InterfaceAlias "$response" -NetBIOS Disabled
Write-Host "NBT-NS disabled for the $response interface."

Set-GPRegistryValue -Name "DisableLLMNR" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" -ValueName "EnableMulticast" -Value 0 -Type DWord
Write-Host "LLMNR disabled. Vaccination complete."

Write-Host "NOTE: System restart required for the disabling of NBT-NS to take effect." -ForegroundColor Red
