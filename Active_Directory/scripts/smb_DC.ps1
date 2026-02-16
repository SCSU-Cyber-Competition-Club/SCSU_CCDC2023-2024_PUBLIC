#SMB is scary. SMB is needed in our environment. We want to enable SMBv3. Doing so is a bit unintuitive, however.
#There is no command to "enable SMBv3". Rather, we need to have SMB2 enabled, and then enable the settings that are associated with SMB3, i.e. encrypting
#data and implementing SMB signing.
#Furthermore, particular to SMB signing, this needs to be required and enable for the server in the ...LanManServer registry path on the domain controller.
#However, if it's not enabled on individual client machines, then SMB traffic will fail, as the client is being required to sign, which it isn't doing.
#As such, there are two scripts for this process: this one for the domain controller server, and another for Windows client machines.
Write-Host "Hardening server SMB..." -ForeGroundColor Red
Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force
Set-SmbServerConfiguration -EnableSMB2Protocol $true -Force
Set-SmbServerConfiguration -EncryptData $true
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "EnableSecuritySignature" -Value 1 -Type DWord -Force
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "RequireSecuritySignature" -Value 1 -Type DWord -Force
Write-Host "Server SMB Hardened." -ForeGroundColor Red

