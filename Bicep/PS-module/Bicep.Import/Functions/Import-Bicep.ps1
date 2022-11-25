<#
    .SYNOPSIS
        Import Azure resources to Bicep configuration files
        Version:1.0
        Author: Charbel HANNA
        Twitter: @charbelh
        website:https://zerohoursleep.net
         
    .DESCRIPTION
        Function that is used to import existing resources inside a single subscription to Bicep files
        - Get ARM template json files
        - Generate Bicep modules
        
    .PARAMETER
        
        -SourcePath
                Specifies the path (root folder) for the source files.

                    Required                        true
    
                    Position                        1

        -OutputPath
                Specifies the path (root folder) to be used to store the exported resources files.

                    Required                        true
    
                    Position                        1
    .INPUTS
     None. You cannot pipe objects to Import-Bicep.ps1
    
    .EXAMPLE
        PS> Import-Bicep -SourcePath "c:\MyexportedResources"
    
    .EXAMPLE
        PS> Import-Bicep -SourcePath "c:\MyexportedResources" -OutputPath ""   
    
#>
[array]$patterns = ("parameters","bicep","schema","parameters")
$Filter = ($Patterns | Foreach-Object { [regex]::escape($_) }) -join '|' 

function import-Bicep {
    [cmdletbinding()]
    param(   
        [Parameter(Mandatory, position = 0)]
        [ValidateScript({ Test-Path $_ -PathType ‘Container’ })]
        [string]$SourcePath,
        [Parameter(position = 1)]
        [ValidateScript({ Test-Path $_ -PathType ‘Container’ })]
        [string]$OutputPath = $SourcePath
    )
    process {
        
        $assets = Get-ChildItem -Path $SourcePath -File | Where-Object {($_.name -Notmatch $Filter)} | Select-Object -ExpandProperty FullName
        write-host "found the following assests" 
        write-output $assets 
        $assets | foreach-object {

            # Bicep Decompile $_ | Tee-Object -FilePath "$SourcePath\log.txt" -Append | Out-Null
            $file = $_.trimend(".json")
            $file = "$file.bicep"
            if(!(Test-Path -path $file)){ 
                write-host "processing file name "$_ -ForegroundColor cyan
                   az bicep decompile -f $_  2>$logfile  
            } else {
                write-host "file already exist... skipping Bicep generation" -ForegroundColor yellow
            }
        }
             
    }
    end {
    }
}

    