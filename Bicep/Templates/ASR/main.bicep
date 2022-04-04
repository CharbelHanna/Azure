targetScope = 'subscription'

param DepartmentCode string
param ApplicationName string
param AppEnvironment string
param LocationCode string
param FreeTextForAsrName string
param ExistingResourceGroupName string
param ExistingVirtualNetworkRGName string
param ExistingVirtualNetworkName string
param ExistingSubnetNAME string

var location = deployment().location
var VaultName = '${DepartmentCode}${ApplicationName}${AppEnvironment}${LocationCode}asr${FreeTextForAsrName}'
var PrivateEndpointName = '${DepartmentCode}${ApplicationName}${AppEnvironment}${LocationCode}pe${FreeTextForAsrName}'
var virtualNetworkId = '${subscription().id}/resourceGroups/${ExistingVirtualNetworkRGName}/providers/Microsoft.Network/virtualNetworks/${ExistingVirtualNetworkName}'
var contributor = '${subscription().id}/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' existing = {
  name: ExistingResourceGroupName
}
resource VNETrg 'Microsoft.Resources/resourceGroups@2021-04-01' existing = {
  name: ExistingVirtualNetworkRGName
}

module DeployVault './Deploy-Vault.bicep' = {
  name: 'DeployVault'
  scope: rg
  params: {
    location:location
    vaultName: VaultName
    role:contributor
  }
  
}
module Private_endpointdeployment './Deploy-PrivateEndpoint.bicep' = {
  name: 'Private-endpointdeployment'
  scope: VNETrg
  params: {
    location:location
    vaultID: DeployVault.outputs.vaultID
    vaultPrincipalID: DeployVault.outputs.vaultPrincipalID
    role:contributor
    PrivateEndpointName: PrivateEndpointName
    VirtualNetworkId: virtualNetworkId
    ExistingSUBNETName: ExistingSubnetNAME
  }
}
