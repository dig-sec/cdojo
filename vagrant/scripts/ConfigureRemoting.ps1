# Enable WinRM on HTTP from the local subnet
Set-Item -Path WSMan:\localhost\Listener\*\IPAddress -Value "*" -Force
Set-Item -Path WSMan:\localhost\Listener\*\Enabled -Value $true -Force

# Configure the firewall to allow WinRM traffic
New-NetFirewallRule -DisplayName "WinRM HTTP-In" -Direction Inbound -Protocol TCP -LocalPort 5985 -Action Allow

# Restart the WinRM service
Restart-Service WinRM