<#
    .SYNOPSIS
        Build paramter json file
        Version:1.0
        Author: Charbel HANNA
        Twitter: @charbelh
        website:https://zerohoursleep.net
         
    .DESCRIPTION
        Function that is used to build parameter file for a bicep project
        - Get distinct parameters
        - Create paramter file 
        - inject parameters in json file
        
    .PARAMETER
        -SourcePath
                    Specifies the path of the source (root folder) templates to be used for parameters extraction
                    
                        Required                        true
                        Position                        0
                        Default value       
                        Accept pipeline input?          false
                        Accept wildecard characters?    false
        
        -OutputPath
                Specifies the path (root folder) to be used to store the exported parameters files.

                    Required                        False
                    Position                        1
                    Default value                   -SourcePath
                    Accept pipeline input?          false
                    Accept wildecard characters?    false
    
    .INPUTS
     None. You cannot pipe objects to Export-AzResources.ps1
    
    .EXAMPLE
        PS> Set-ProjectParameters -SourcePath "c:\MyExportedResources"
    
    .EXAMPLE
        PS> Set-ProjectParameters -SourcePath "c:\MyExportedResources" -OutputPath "c:\MyexportedResources\Parameters".
#>

$Allparams = [PSCustomObject]@{}
$TempVar = [PSCustomObject]@{}
$values = [PSCustomObject]@{}
$schema = "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#"
$contentVersion = "1.0.0.0"

function Copy-PSObject ($From, $To) {
    $properties = Get-Member -InputObject $From -MemberType NoteProperty
    foreach ($p in $properties) {
        $values | Add-Member -NotePropertyMembers @{value=$From.$($p.Name).defaultvalue} -Force
        $To | Add-Member -MemberType NoteProperty -Name $p.Name -Value $values -Force
        $values = [PSCustomObject]@{}
    }
}
   
function Set-ProjectParameters {
    [cmdletbinding()]
    param (
        [Parameter(Mandatory, position = 0)]
        [ValidateScript({Test-Path $_ -PathType ‘Container’})]
        [string]$SourcePath,
        [Parameter(position = 1)]
        [ValidateScript({Test-Path $_ -PathType ‘Container’})]
        [string]$OutputPath = $SourcePath

    )  
    process {
        $assets = Get-ChildItem -Path $SourcePath -File | Where-Object { $_.name -notlike "*parameters*" }
        $assets | foreach-object {
            write-host "processing file name " $_.name -ForegroundColor cyan
          
            $TempVar = Get-Content -path (Join-Path $SourcePath $_.Name) | ConvertFrom-Json
            if($tempvar.parameters){
                write-host $_.name "is a valid json file" -ForegroundColor Green   
                $TempVar = $TempVar.parameters
                Copy-PSObject -From $TempVar -To $Allparams
                write-host `n
                write-host "found the following parameters" -ForegroundColor cyan 
                $Allparams | Format-List 
            }
            
        } 
    }
    end {
        Write-Host "Generating parameters file at " $OutputPath\parameters.json -ForegroundColor cyan
        #$Allparams = $Allparams | ConvertTo-Json
        $Template = [PSCustomObject]@{
            '$schema' = $schema
            contentVersion = $contentVersion
            parameters = $Allparams
        }
        #write-host " saving parameters file at " $OutputPath\parameters.json
        $template = $template | ConvertTo-Json
        $Template | Set-Content -Path $OutputPath\parameters.json 
        write-host `n
        write-host $Template -ForegroundColor Yellow
    }
}

