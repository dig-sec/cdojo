# Disable Windows Firewall
if ([System.Environment]::OSVersion.Version.Major -ge 10) {
    Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
}
else {
    Set-NetFirewallProfile -Profile Domain,Public -Enabled False
}