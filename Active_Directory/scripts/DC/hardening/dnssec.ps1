## If I explain DNSSec in commentation, this file will be 3x as large. Find the article that explains it best for ya.

 # Function to set up DNSSEC for a given zone
function Set-DNSSECForZone {
    param (
        [string]$ZoneName
    )

    # Step 1: Configure DNSSEC with default settings
    Write-Host "Setting up DNSSEC for zone: $ZoneName"
    Invoke-DnsServerZoneSign -Zonename $ZoneName -SignWithDefault
    Write-Host "DNSSEC configured with default settings for $ZoneName..."

    # Step 2: Enable distribution of trust anchors
    Set-DnsServerDnsSecZoneSetting -Zonename $ZoneName -DistributeTrustAnchor Dnskey
    Write-Host "Trust anchor distribution enabled for $ZoneName."
}

# Main script
do {
    # Step 1: Ask for the zone name
    $zone = Read-Host "Enter the zone name to set up DNSSEC:"

    # Step 2: Set up DNSSEC for the zone
    Set-DNSSECForZone -ZoneName $zone

    # Step 3: Ask if there is another zone to configure
    $anotherZone = Read-Host "Would you like to set up DNSSEC for another zone? (Don't forget the _msdcs zones!) (Y/N)"
} while ($anotherZone -eq 'Y' -or $anotherZone -eq 'y')

Write-Host "DNSSEC setup complete."
