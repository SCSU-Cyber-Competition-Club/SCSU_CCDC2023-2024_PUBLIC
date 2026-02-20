<#
.SYNOPSIS
    CCDC Hardening Script - Verbose Error Reporting Enabled
    Run as Administrator.
#>

$ErrorActionPreference = "Continue" # Ensure errors are displayed

function Secure-Service {
    param (
        [string]$ServiceName,
        [string]$Description
    )
    Write-Host "Checking $Description ($ServiceName)..." -NoNewline
    
    if (Get-Service $ServiceName -ErrorAction SilentlyContinue) {
        try {
            Stop-Service $ServiceName -Force -ErrorAction Stop
            Set-Service $ServiceName -StartupType Disabled -ErrorAction Stop
            Write-Host " [DISABLED]" -ForegroundColor Green
        }
        catch {
            Write-Host " [ERROR]" -ForegroundColor Red
            Write-Error $_.Exception.Message
        }
    }
    else {
        Write-Host " [NOT INSTALLED/FOUND]" -ForegroundColor Gray
    }
}

function Remove-Feature {
    param (
        [string]$FeatureName,
        [string]$Description
    )
    Write-Host "Removing $Description ($FeatureName)..." -NoNewline
    
    try {
        # Check if feature is actually installed first to avoid unnecessary errors
        $feat = Get-WindowsOptionalFeature -Online -FeatureName $FeatureName -ErrorAction SilentlyContinue
        if ($feat.State -eq "Enabled") {
            Disable-WindowsOptionalFeature -Online -FeatureName $FeatureName -NoRestart -ErrorAction Stop | Out-Null
            Write-Host " [REMOVED]" -ForegroundColor Green
        }
        else {
            Write-Host " [ALREADY DISABLED]" -ForegroundColor Gray
        }
    }
    catch {
        Write-Host " [ERROR]" -ForegroundColor Red
        Write-Error $_.Exception.Message
    }
}

function Set-RegKey {
    param (
        [string]$Path,
        [string]$Name,
        [string]$Value,
        [string]$Type = "DWord",
        [string]$Description
    )
    Write-Host "Setting $Description..." -NoNewline
    try {
        if (-not (Test-Path $Path)) {
            New-Item -Path $Path -Force -ErrorAction Stop | Out-Null
        }
        New-ItemProperty -Path $Path -Name $Name -Value $Value -PropertyType $Type -Force -ErrorAction Stop | Out-Null
        Write-Host " [OK]" -ForegroundColor Green
    }
    catch {
        Write-Host " [ERROR]" -ForegroundColor Red
        Write-Error $_.Exception.Message
    }
}

Write-Host "--- STARTING HARDENING (VERBOSE MODE) ---" -ForegroundColor Cyan

# --- 1. REMOVE FEATURES ---
Remove-Feature -FeatureName "MicrosoftWindowsPowerShellV2Root" -Description "PowerShell v2.0"
Remove-Feature -FeatureName "SMB1Protocol" -Description "SMBv1 Protocol"
Remove-Feature -FeatureName "Telnet-Client" -Description "Telnet Client"
Remove-Feature -FeatureName "Telnet-Server" -Description "Telnet Server"    

# --- 2. DISABLE SERVICES ---
Secure-Service -ServiceName "SSDPSRV" -Description "UPnP Discovery"
Secure-Service -ServiceName "upnphost" -Description "UPnP Host"
Secure-Service -ServiceName "Spooler" -Description "Print Spooler"
Secure-Service -ServiceName "RemoteRegistry" -Description "Remote Registry"
Secure-Service -ServiceName "XblAuthManager" -Description "Xbox Auth Manager"
Secure-Service -ServiceName "XblGameSave" -Description "Xbox Game Save"
Secure-Service -ServiceName "XboxNetApiSvc" -Description "Xbox Net API"
Secure-Service -ServiceName "DiagTrack" -Description "Telemetry (DiagTrack)"
Secure-Service -ServiceName "bthserv" -Description "Bluetooth Service"
Secure-Service -ServiceName "MapsBroker" -Description "Downloaded Maps Manager"
Secure-Service -ServiceName "lfsvc" -Description "Geolocation Service"
Secure-Service -ServiceName "WerSvc" -Description "Windows Error Reporting"

# --- 3. REGISTRY HARDENING ---
Set-RegKey -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DNSClient" -Name "EnableMulticast" -Value 0 -Description "LLMNR (Disable Multicast)"
Set-RegKey -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp" -Name "DisableWpad" -Value 1 -Description "WPAD (Disable Auto-Proxy)"
Set-RegKey -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" -Name "DisabledComponents" -Value 0xff -Description "IPv6 (Disable Components)"
Set-RegKey -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\ScriptedDiagnostics" -Name "EnableDiagnostics" -Value 0 -Description "MSDT (Follina Fix)"
Set-RegKey -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoDriveTypeAutoRun" -Value 255 -Description "Autoplay (Disable All Drives)"

Write-Host "Forcing WPAD Disable via Registry..." -ForegroundColor Cyan
try {
    # 'Start' = 4 means Disabled
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WinHttpAutoProxySvc" -Name "Start" -Value 4 -Force -ErrorAction Stop
    Write-Host " [SUCCESS] WPAD set to disabled. It will not start after reboot." -ForegroundColor Green
}
catch {
    Write-Host " [FATAL ERROR] Registry access denied. Check if Red Team has locked the keys." -ForegroundColor Red
    Write-Error $_.Exception.Message
}
# --- 4. AUTHENTICATION (NTLM) ---
# NTLMv1 Removal / Force NTLMv2
Set-RegKey -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name "LmCompatibilityLevel" -Value 5 -Description "NTLM Hardening (Level 5)"
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Lsa\MSV1_0" -Name "RestrictIncomingNTLMTraffic" -Value 2
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Lsa\MSV1_0" -Name "RestrictSendingNTLMTraffic" -Value 2

# --- 5. NETBIOS DISABLE ---
Write-Host "Disabling NetBIOS on Network Adapters..." -NoNewline
try {
    $adapters = Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter "IPEnabled = True" -ErrorAction Stop
    foreach ($adapter in $adapters) {
        $adapter.SetTcpipNetbios(2) | Out-Null
    }
    Write-Host " [OK]" -ForegroundColor Green
}
catch {
    Write-Host " [ERROR]" -ForegroundColor Red
    Write-Error $_.Exception.Message
}

# --- 6. THIRD PARTY CHECK ---
Write-Host "Searching for VNC/TeamViewer..."
try {
    $software = Get-WmiObject -Class Win32_Product -ErrorAction Stop | Where-Object { $_.Name -match "VNC" -or $_.Name -match "TeamViewer" }
    if ($software) {
        Write-Host "WARNING: FOUND THE FOLLOWING SOFTWARE:" -ForegroundColor Magenta
        $software | Select-Object Name, Version | Format-Table -AutoSize
        Write-Host "ACTION REQUIRED: Please manually uninstall these via Control Panel." -ForegroundColor Yellow
    } else {
        Write-Host "No VNC or TeamViewer found via WMI." -ForegroundColor Green
    }
}
catch {
    Write-Host " [ERROR SEARCHING INSTALLED APPS]" -ForegroundColor Red
    Write-Error $_.Exception.Message
}

Write-Host "--- DONE. PLEASE REBOOT. ---" -ForegroundColor Cyan
