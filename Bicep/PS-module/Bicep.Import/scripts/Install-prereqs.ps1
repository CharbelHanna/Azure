
<#
    .SYNOPSIS
        Install Bicep import module prerequisites
        Version:1.0
        Author: Charbel HANNA
        Twitter: @charbelh
        website:https://zerohoursleep.net
         
    .DESCRIPTION
        script that checks for a valid Az cli installation 
        upgrade existing az cli installation
        install az cli

#>

$AzCliMinimumVersion = "2.36.0"
$AzCliVersionInfo = @()

write-host "Checking Az cli installation" -ForegroundColor yellow
if (where.exe az.cmd) {
    $AzCliVersionInfo = az --version
    write-host "found ac cli"
    if ($AzCliVersionInfo[0] -lt $AzCliMinimumVersion) {
        write-host "The installed AZ Cli version is lower than the Minimum required version $AzCliMinimumVersion"
        write-host "proceeding with az cli upgrade..."
        az upgrade --yes -y 
    }
    else {
        write-host "az cli found and up to date! no action is required" -ForegroundColor cyan
    }
}
else {
    write-host "az cli not found!" -ForegroundColor yellow
    write-host "proceeding with installing the latest version"
    Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi
    Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi/quiet'
    Remove-Item .\AzureCLI.msi
}