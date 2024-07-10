param (
    [Parameter(Mandatory=$true)]
    [string]$IP,
   
    [Parameter(Mandatory=$true)]
    [string]$Gateway
)

# Get the interface index
$interface = Get-NetIPAddress -IPAddress $IP | Select-Object -ExpandProperty InterfaceIndex

# Set the default gateway
New-NetRoute -DestinationPrefix "0.0.0.0/0" -InterfaceIndex $interface -NextHop $Gateway

# Set DNS servers
Set-DnsClientServerAddress -InterfaceIndex $interface -ServerAddresses ("1.1.1.1", "8.8.8.8")

# Output confirmation
Write-Host "Network configuration completed:"
Write-Host "IP: $IP"
Write-Host "Gateway: $Gateway"
Write-Host "DNS Servers: 1.1.1.1, 8.8.8.8"