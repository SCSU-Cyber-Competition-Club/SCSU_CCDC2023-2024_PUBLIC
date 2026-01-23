#SMB is scary. SMB is needed in our environment. We want to enable SMBv3. SMBv3 will brick everything. We will enable SMBv2.
#I'll leave information on enabling SMBv3 commented at the bottom of this script, if anyone decides to give it a shot.
#For our purposes, though, it's a bit overkill. There's probably better things you can spend your time on.
#My assumption as to why it bricks things and what would need to be done additionally to make it work is that
#it requires a CA to implement the signatures.


Write-Host "Hardening server SMB..." -ForeGroundColor Red
Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force
Set-SmbServerConfiguration -EnableSMB2Protocol $true -Force

Write-Host "Server SMB Hardened." -ForeGroundColor Red


#There is no command to "enable SMBv3". Rather, we need to have SMB2 enabled, and then enable the settings that are associated with SMB3, i.e. encrypting
#data and implementing SMB signing.
#Furthermore, particular to SMB signing, this needs to be required and enable for the server in the ...LanManServer registry path on the domain controller.
#However, if it's not enabled on individual client machines, then SMB traffic will fail, as the client is being required to sign, which it isn't doing.
#As such, there are two scripts for this process: this one for the domain controller server, and another for Windows client machines.
#Here are the commands pertinent to SMBv3.
#AGAIN, DO NOT UNCOMMENT THIS UNLESS YOU KNOW HOW TO GET SMBv3 TO WORK PROPERLY. YOUR DOMAIN WILL BRICK.
#Set-SmbServerConfiguration -EncryptData $true
#Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "EnableSecuritySignature" -Value 1 -Type DWord -Force
#Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "RequireSecuritySignature" -Value 1 -Type DWord -Force


