# Setting these values implements "EPA", which forces NTLMv2 to be used over NTLM.
# This is recycled as we just want to use Kerberos authentication over NTLMv2 authentication, which is much weaker.
# You would only use NTLMv2 in an environment with old-ass systems/operating systems which need the legacy NTLM/NTLMv2 protocol.
Write-Host "Implementing EPA..." -ForeGroundColor Red
 
 Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Lsa" -Name "LmCompatibilityLevel" -Value 5
Write-Host "LMCompatability set to 5. NTLMv2 enforced."

Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Lsa" -Name "SuppressExtendedProtection" -Value 0
Write-Host "SuppressExtendedProtection set to 0..."

Write-Host "EPA implemented." -ForeGroundColor Red
