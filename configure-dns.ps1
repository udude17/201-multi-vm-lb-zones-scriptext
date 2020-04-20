<#
    .SYNOPSIS
        installs the Windows Server DNS role and a test folder
#>

# Force use of TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Firewall
# netsh advfirewall firewall add rule name="http" dir=in action=allow protocol=TCP localport=80
# netsh advfirewall firewall add rule name="dnstcp" dir=in action=allow protocol=TCP localport=53
# netsh advfirewall firewall add rule name="dnsudp" dir=in action=allow protocol=UDP localport=53

# Folder for testing & for csv download
New-Item -ItemType Directory c:\temp

# Install DNS Role
Install-WindowsFeature DNS -IncludeManagementTools

$url = "https://sharefileuwhoffmaweu.blob.core.windows.net/scripts/DNSForwardingEntries.csv"
$output = "c:\temp\DNSForwardingEntries.csv"
Invoke-WebRequest -Uri $url -OutFile $output

$dnsidlist = Import-CSV -Path $output 

foreach ($dns in $dnsidlist)
{
    Add-DnsServerConditionalForwarderZone -Name $dns.ZoneName -MasterServers $dns.TargetDnsServer1 -PassThru
    # Write-Host $dns.ZoneName $dns.TargetDnsServer1 $dns.TargetDnsServer2 -ForegroundColor Yellow
}

# Restart-Computer -Delay 15
