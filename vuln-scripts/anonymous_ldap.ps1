<#
.SYNOPSIS
This PowerShell script grants read and execute permissions to the "NT AUTHORITY\ANONYMOUS LOGON" account on a specified Active Directory object.

.DESCRIPTION
The script creates an access rule that allows the "NT AUTHORITY\ANONYMOUS LOGON" account to read properties and execute actions on the specified Active Directory object. It then adds this access rule to the object's access control list (ACL) and sets the modified ACL on the object.

.PARAMETER DCPathEnd
Specifies the path of the Active Directory object on which the permissions are to be granted. This should be in the format "DC=domain,DC=com".

.EXAMPLE
Grant-AnonymousAccess -DCPathEnd "DC=example,DC=com"
#>
$anonymousId = New-Object System.Security.Principal.NTAccount "NT AUTHORITY\ANONYMOUS LOGON"
$secInheritanceAll = [System.DirectoryServices.ActiveDirectorySecurityInheritance] "All"
$Ace = New-Object System.DirectoryServices.ActiveDirectoryAccessRule $anonymousId,"ReadProperty, GenericExecute","Allow",$secInheritanceAll
$Acl = Get-Acl -Path "AD:$($node.DCPathEnd)"
$Acl.AddAccessRule($Ace)
Set-Acl -Path "AD:$($node.DCPathEnd)" -AclObject $Acl