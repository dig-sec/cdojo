@{

# Script module or binary module file associated with this manifest.
RootModule = '.\ADCSTemplate.psm1'

# Version number of this module.
ModuleVersion = '1.0.1.1'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = '9256f6a5-b961-4e9c-a0b1-75b322104186'

# Author of this module
Author = 'Ashley McGlone'

# Company or vendor of this module
# CompanyName = 'COMMUNITY'

# Copyright statement for this module
# Copyright = '(c) 2018 Administrator. All rights reserved.'

# Description of the functionality provided by this module
Description = '
Create Certificate Template in ADCS
by Ashley McGlone
http://aka.ms/GoateePFE
@GoateePFE

Module of functions to export, import, permission, and remove AD CS templates.
Includes DSC resource for importing templates from a JSON string.

Requirements:
-Enterprise AD CS PKI
-Tested on 2012 R2 & 2016
-Enterprise Administrator rights
-ActiveDirectory PowerShell Module
-PowerShell v5.x
'

# Minimum version of the Windows PowerShell engine required by this module
# PowerShellVersion = ''

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @('Export-ADCSTemplate','Get-ADCSTemplate','New-ADCSDrive','New-ADCSTemplate','Remove-ADCSTemplate','Set-ADCSTemplateACL')

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# DSC resources to export from this module
DscResourcesToExport = @('ADCSTemplate')

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @('DSCResource','certificate','template','ADCS','ActiveDirectoryCertificateServices','ActiveDirectory','encryption','DSC','CMS')

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/GoateePFE/ADCSTemplate/blob/master/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/GoateePFE/ADCSTemplate'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        ReleaseNotes = '
            1.0.0.0 - Initial release
            1.0.1.0 - Fixed issues with DisplayName vs cn when working with the template objects, removed Deny/Read ACL possibility
        '

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

