<#
.SYNOPSIS
Enables SID history for a trust relationship between two domains.

.DESCRIPTION
This script uses the 'netdom' command to enable SID history for a trust relationship between the 'corp.local' and 'secure.local' domains.

.PARAMETER trust
Specifies the trust relationship to configure SID history for.

.EXAMPLE
netdom trust corp.local /d:secure.local /enablesidhistory:yes
#>
netdom trust corp.local /d:secure.local /enablesidhistory:yes