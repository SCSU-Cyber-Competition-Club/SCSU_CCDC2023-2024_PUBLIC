Write-Host "Initiating NetBIOS script..." -ForeGroundColor Red

$base = "HKLM:SYSTEM\CurrentControlSet\Services\NetBT\Parameters\Interfaces"

$interfaces = Get-ChildItem $base | Select -ExpandProperty PSChildName

foreach($interface in $interfaces) {
    Set-ItemProperty -Path "$base\$interface" -Name "NetbiosOptions" -Value 2
}

Write-Host "NetBIOS disabled." -ForeGroundColor Red
Write-Host "Remember, you must restart the computer for this change to take effect!" -ForeGroundColor Green
