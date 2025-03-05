Write-Host "Implementing EPA..." -ForeGroundColor Red
 
 Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Lsa" -Name "LmCompatibilityLevel" -Value 5
Write-Host "LMCompatability set to 5. NTLMv2 enforced."

Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Lsa" -Name "SuppressExtendedProtection" -Value 0
Write-Host "SuppressExtendedProtection set to 0..."

Write-Host "EPA implemented." -ForeGroundColor Red
