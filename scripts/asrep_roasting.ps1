<#
.SYNOPSIS
This PowerShell script is used to enable AS-REP Roasting for a specific user in Active Directory.

.DESCRIPTION
The script retrieves the specified user from Active Directory using the Get-ADUser cmdlet and then sets the DoesNotRequirePreAuth attribute to $true using the Set-ADAccountControl cmdlet. This attribute controls whether the user account requires pre-authentication, and setting it to $true allows AS-REP Roasting for the user.

.PARAMETER Identity
Specifies the identity of the user for whom AS-REP Roasting needs to be enabled. This can be the username or any other attribute that uniquely identifies the user.

.EXAMPLE
Enable-ASRepRoasting -Identity "username"
This example enables AS-REP Roasting for the user with the username "username".

.NOTES
- This script requires the Active Directory module to be installed.
- You need to run this script with appropriate administrative privileges.
#>
Get-ADUser -Identity "username" | Set-ADAccountControl -DoesNotRequirePreAuth:$true