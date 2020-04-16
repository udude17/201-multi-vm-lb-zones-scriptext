<#
    .SYNOPSIS
        installs the Windows Server DNS role and a test folder
#>

# Force use of TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Firewall
# netsh advfirewall firewall add rule name="http" dir=in action=allow protocol=TCP localport=80

# Folder for testing
New-Item -ItemType Directory c:\temp

# Install DNS Role
Install-WindowsFeature DNS -IncludeManagementTools

