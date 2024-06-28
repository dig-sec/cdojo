try {
    Write-Output "Configuring WinRM..."

    # Enable WinRM service if not already enabled
    $winrmService = Get-Service -Name "WinRM"
    if ($winrmService.Status -ne "Running") {
        Set-Service -Name "WinRM" -StartupType Automatic
        Start-Service -Name "WinRM"
        Write-Output "WinRM service started."
    } else {
        Write-Output "WinRM service is already running on this machine."
    }

    # Set WinRM configurations if they are not already set
    $currentWinRMConfig = winrm get winrm/config
    if ($currentWinRMConfig -notmatch "MaxTimeoutms = 1800000") {
        winrm set winrm/config '@{MaxTimeoutms="1800000"}'
        Write-Output "MaxTimeoutms set to 1800000."
    } else {
        Write-Output "MaxTimeoutms is already set to 1800000."
    }

    $currentWinRSConfig = winrm get winrm/config/winrs
    if ($currentWinRSConfig -notmatch "MaxMemoryPerShellMB = 800") {
        winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="800"}'
        Write-Output "MaxMemoryPerShellMB set to 800."
    } else {
        Write-Output "MaxMemoryPerShellMB is already set to 800."
    }

    $currentServiceConfig = winrm get winrm/config/service
    if ($currentServiceConfig -notmatch "AllowUnencrypted = true") {
        winrm set winrm/config/service '@{AllowUnencrypted="true"}'
        Write-Output "AllowUnencrypted set to true."
    } else {
        Write-Output "AllowUnencrypted is already set to true."
    }

    $currentAuthConfig = winrm get winrm/config/service/auth
    if ($currentAuthConfig -notmatch "Basic = true") {
        winrm set winrm/config/service/auth '@{Basic="true"}'
        Write-Output "Basic authentication set to true."
    } else {
        Write-Output "Basic authentication is already set to true."
    }

    $currentClientAuthConfig = winrm get winrm/config/client/auth
    if ($currentClientAuthConfig -notmatch "Basic = true") {
        winrm set winrm/config/client/auth '@{Basic="true"}'
        Write-Output "Client Basic authentication set to true."
    } else {
        Write-Output "Client Basic authentication is already set to true."
    }

    # Check if listener exists before creating
    $existingListener = Get-ChildItem -Path WSMan:\Localhost\Listener |
                        Where-Object { $_.Address -eq "*" -and $_.Transport -eq "HTTP" }

    if (-not $existingListener) {
        # Create new listener
        winrm create winrm/config/listener?Address=*+Transport=HTTP
        Write-Output "WinRM listener created."
    } else {
        Write-Output "WinRM listener already exists."
    }

    # Check and create firewall rule
    $firewallRule = Get-NetFirewallRule -DisplayName "WinRM HTTP-In" -ErrorAction SilentlyContinue
    if (-not $firewallRule) {
        New-NetFirewallRule -DisplayName "WinRM HTTP-In" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 5985
        Write-Output "Firewall rule for WinRM created."
    } else {
        Write-Output "Firewall rule for WinRM already exists."
    }

    # Set network profile to private
    Get-NetConnectionProfile | Set-NetConnectionProfile -NetworkCategory Private

    # Enable PS Remoting
    Enable-PSRemoting -Force

    # Run WinRM quickconfig
    winrm quickconfig -q
    winrm quickconfig -transport:http

    # Configure firewall rules (using netsh for backward compatibility)
    netsh advfirewall firewall set rule group="Windows Remote Administration" new enable=yes
    netsh advfirewall firewall set rule name="Windows Remote Management (HTTP-In)" new enable=yes action=allow remoteip=any

    # Set WinRM service to auto start and restart it
    # Set-Service winrm -StartupType "Automatic"
    # Restart-Service winrm

    Write-Output "WinRM is configured successfully."
}
catch {
    Write-Error "An error occurred while configuring WinRM: $_"
    exit 1
}





# # Enable WinRM on HTTP from the local subnet
# Set-Item -Path WSMan:\localhost\Listener\*\IPAddress -Value "*" -Force
# Set-Item -Path WSMan:\localhost\Listener\*\Enabled -Value $true -Force

# # Configure the firewall to allow WinRM traffic
# New-NetFirewallRule -DisplayName "WinRM HTTP-In" -Direction Inbound -Protocol TCP -LocalPort 5985 -Action Allow

# # Restart the WinRM service
# Restart-Service WinRM