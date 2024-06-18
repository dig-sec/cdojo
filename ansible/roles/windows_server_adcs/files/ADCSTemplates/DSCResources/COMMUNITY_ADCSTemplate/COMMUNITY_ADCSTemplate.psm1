function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $Displayname
    )

    If (Get-ADCSTemplate -DisplayName $DisplayName) {
        Return @{DisplayName = $Displayname}
    } Else {
        Return @{DisplayName = $null}
    }
}


function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $Displayname,

        [System.String]
        $JSON,

        [System.String[]]
        $Identity,

        [System.Boolean]
        $Publish,

        [System.Boolean]
        $AutoEnroll,

        [ValidateSet("Present","Absent")]
        [System.String]
        $Ensure
    )

    If ($Ensure -eq 'Present') {

        Write-Verbose "[ADCS] Creating template $DisplayName"
        $PSBoundParameters.Remove('Ensure')
        $PSBoundParameters.Remove('Verbose')
        New-ADCSTemplate @PSBoundParameters

    } Else {

        Write-Verbose "[ADCS] Removing template $DisplayName"
        Remove-ADCSTemplate $DisplayName -Confirm:$false

    }
}


function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $Displayname,

        [parameter(Mandatory = $true)]
        [System.String]
        $JSON,

        [System.String[]]
        $Identity,

        [System.Boolean]
        $Publish,

        [System.Boolean]
        $AutoEnroll,

        [ValidateSet("Present","Absent")]
        [System.String]
        $Ensure
    )

    # Simple test for existence. Does not validate all template settings or permissions or publishing.
    If (Get-ADCSTemplate -DisplayName $DisplayName) {
        Write-Verbose "[ADCS] Template $DisplayName Present. Should be $Ensure."
        If ($ensure -eq 'Present') {Return $true} Else {Return $false}
    } Else {
        Write-Verbose "[ADCS] Template $DisplayName Absent. Should be $Ensure."
        If ($ensure -eq 'Present') {Return $false} Else {Return $true}
    }

}


Export-ModuleMember -Function *-TargetResource

