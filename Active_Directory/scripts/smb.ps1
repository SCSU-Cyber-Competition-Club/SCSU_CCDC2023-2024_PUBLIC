Write-Host "Hardening SMB..." -ForeGroundColor Red
Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force
Set-SmbServerConfiguration -EnableSMB2Protocol $true -Force
Set-SmbServerConfiguration -EncryptData $true
Write-Host "SMB Hardened." -ForeGroundColor Red

