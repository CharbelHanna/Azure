<#
    .SYNOPSIS
        Export all existing resources inside a single subscription to json files
        Version:1.0
        Author: Charbel HANNA
        Twitter: @charbelh
        website:https://zerohoursleep.net
         
    .DESCRIPTION
        Function that is used to export all existing resources inside a single subscription to json files
        - Get Resrouce Groups
        - Support Exclusions
        
    .PARAMETER
        -SubscriptionId
                    Specifies the Id of the subscription to be exported. 
                    
                        Required                        true
                        Position                        0
                        Default value       
                        Accept pipeline input?          false
                        Accept wildecard characters?    false

        -ExcludedResourceGroups
                    Specifies the list of resource groups to be excluded. 
                    
                        Required                        false
                        Position                        1
                        Default value       
                        Accept pipeline input?          false
                        Accept wildecard characters?    false
        
        -OutputPath
                Specifies the path (root folder) to be used to store the exported resources files.

                    Required                        true
    
                    Position                        1
    
    .INPUTS
     None. You cannot pipe objects to Export-AzResources.ps1
    
    .EXAMPLE
        PS> Export-Azresources -subscriptionId <subscriptionid> -ExcludedResourceGroups "Default-rg" -OutputPath "c:\MyexportedResources"
    
    .EXAMPLE
        PS> Export-Azresources -subscriptionId <subscriptionid> -OutputPath "c:\MyexportedResources"
    #>
function Export-AzResources {
    [CmdletBinding()]
    param (
        [parameter(Mandatory, Position = 0)]
        [string]$SubscriptionId,
        [parameter(Position = 1)]
        [array]$ExcludedResourceGroups,
        [parameter(Mandatory, Position = 2)]
        [string]$OutputPath       
    )
    
    begin {
        [array]$DefaultExclusions = ("cloud-shell-storage")
        $OutputPath = Join-Path $OutputPath $SubscriptionId
        write-host "Initialzing context" -ForegroundColor cyan
        set-azcontext   -SubscriptionId $SubscriptionId 
    }
    
    process {
        
        $ExcludedResourceGroups = $ExcludedResourceGroups.Split(',')
        $ExcludedResourceGroups = $ExcludedResourceGroups + $DefaultExclusions
        $RegExFilter = ($ExcludedResourceGroups | Foreach-Object { [regex]::escape($_) }) -join '|'      #$DefaultExclusions | foreach-object {$ExcludedResourceGroups +=$_}
        Write-Output "the following resource groups will be excluded" -ForegroundColor yellow
        $ExcludedResourceGroups = Get-AzResourceGroup | Where-Object { ($_.resourceGroupName -match $RegExFilter) }
        Write-Output  $ExcludedResourceGroups | Format-Table ResourceGroupName, ResourceId
        Write-Output  "working on the following resrouce groups"
        $ResourceGroups = Get-AzResourceGroup | Where-Object { ($_.resourceGroupName -Notmatch $RegExFilter) }
        Write-Output  $ResourceGroups | Format-Table ResourceGroupName, ResourceId  

        if (!(test-path -Path $OutputPath)) {
            write-Output "creating the following output path" $OutputPath -ForegroundColor cyan
            New-Item -path $OutputPath -ItemType Directory | Out-Null
        } 
        else {
            write-Output "Target folder $outputPath already exists, existing entries will be overwritten"  -ForegroundColor yellow
        }
        write-Output "Exporting..." -ForegroundColor cyan
        ForEach ($ResourceGroup in $ResourceGroups) {
            write-output $ResourceGroup.resourceGroupName 
            $ExportPath = Join-Path $Outputpath $ResourceGroup.ResourceGroupName
            Export-AzResourcegroup -ResourceGroupName $ResourceGroup.ResourceGroupName -path "$ExportPath.json" -IncludeParameterDefaultValue -Force | Out-Null
        }


        
    }
    end {
        
    }
}