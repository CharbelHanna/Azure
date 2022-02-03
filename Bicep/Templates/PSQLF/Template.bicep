@description('The team or department unique code')
param DepartmentCode string

@description('The name of the application that the resource is deployed for')
param ApplicationName string

@description('The environment of the application where the resource is deployed')
param AppEnvironment string

@description('The Location Code of the application where the resource is deployed')
param LocationCode string

@description('The Administrator Login of the application')
param administratorLogin string

@description('The Administrator Login Password of the application')
@secure()
param administratorLoginPassword string

@description('Name of the application')
param FreeTextForName string

@description('Version of the application')
param version string

@description('Virtual NetworkId to integrate the application')
param virtualNetworkId string

@description('Specify Delegated Subnet Name')
param delegatedSubnetName string
param DelegatedSubnetAddressPrefix string
param DelegatedSubnetNSGId string

var serverName_var = '${DepartmentCode}${ApplicationName}${AppEnvironment}${LocationCode}psqlf${FreeTextForName}'
var arrvirtualNetworkId = split(virtualNetworkId, '/')
var privateDnsResourceGroup = arrvirtualNetworkId[4]
var privateDnsSubscriptionId = arrvirtualNetworkId[2]
var virtualNetworkName = last(arrvirtualNetworkId)
var privateDnsZoneName = '${serverName_var}.private.postgres.database.azure.com'
var privateDnsZoneArguments = {
  PrivateDnsZoneArmResourceId: '/subscriptions/${privateDnsSubscriptionId}/resourceGroups/${privateDnsResourceGroup}/providers/Microsoft.Network/privateDnsZones/${privateDnsZoneName}'
}
var delegatedSubnetId = '/subscriptions/${privateDnsSubscriptionId}/resourceGroups/${privateDnsResourceGroup}/providers/Microsoft.Network/virtualNetworks/${virtualNetworkName}/subnets/${delegatedSubnetName}'
var delegatedSubnetArguments = {
  SubnetArmResourceId: delegatedSubnetId
}
var subnetProperties = {
  provisioningState: 'Succeeded'
  addressPrefix: DelegatedSubnetAddressPrefix
  networkSecurityGroup: {
    id: DelegatedSubnetNSGId
  }
  delegations: [
    {
      name: 'dlg-Microsoft.DBforPostgreSQL-flexibleServers'
      properties: {
        serviceName: 'Microsoft.DBforPostgreSQL/flexibleServers'
      }
    }
  ]
  privateEndpointNetworkPolicies: 'Disabled'
  privateLinkServiceNetworkPolicies: 'Enabled'
}
var virtualNetworkDeploymentName_var = toLower('virtualNetwork${uniqueString(resourceGroup().id)}')
var virtualNetworkLinkDeploymentName_var = toLower('virtualNetworkLink${uniqueString(resourceGroup().id)}')
var privateDnsZoneDeploymentName_var = toLower('privateDnsZone${uniqueString(resourceGroup().id)}')

module privateDnsZoneDeploymentName 'privateDnsZoneDeployment.bicep' = {
  name: privateDnsZoneDeploymentName_var
  scope: resourceGroup(privateDnsSubscriptionId, privateDnsResourceGroup)
  params: {
    variables_privateDnsZoneName: privateDnsZoneName
  }
}

module virtualNetworkDeploymentName 'virtualNetworkDeployment.bicep' = {
  name: virtualNetworkDeploymentName_var
  scope: resourceGroup(privateDnsSubscriptionId, privateDnsResourceGroup)
  params: {
    variables_virtualNetworkName: virtualNetworkName
    variables_subnetProperties: subnetProperties
    delegatedSubnetName: delegatedSubnetName
  }
}

module virtualNetworkLinkDeploymentName 'virtualNetworkLinkDeployment.bicep' = {
  name: virtualNetworkLinkDeploymentName_var
  scope: resourceGroup(privateDnsSubscriptionId, privateDnsResourceGroup)
  params: {
    variables_privateDnsZoneName: privateDnsZoneName
    virtualNetworkId: virtualNetworkId
  }
  dependsOn: [
    privateDnsZoneDeploymentName
  ]
}

resource serverName 'Microsoft.DBForPostgreSql/flexibleServers@2020-02-14-preview' = {
  location: resourceGroup().location
  name: serverName_var
  properties: {
    version: version
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
    publicNetworkAccess: 'Disabled'
    DelegatedSubnetArguments: (empty(delegatedSubnetArguments) ? json('null') : delegatedSubnetArguments)
    PrivateDnsZoneArguments: (empty(privateDnsZoneArguments) ? json('null') : privateDnsZoneArguments)
    haEnabled: 'Disabled'
    storageProfile: {
      storageMB: 131072
      backupRetentionDays: 7
      geoRedundantBackup: 'Disabled'
    }
    availabilityZone: ''
  }
  sku: {
    name: 'Standard_D2ds_v4'
    tier: 'GeneralPurpose'
  }
  dependsOn: [
    virtualNetworkLinkDeploymentName
  ]
}

output DelegatedSubnetArguments object = delegatedSubnetArguments
output PrivateDnsZoneArguments object = privateDnsZoneArguments
output virtualNetworkLinkDeploymentName string = virtualNetworkLinkDeploymentName_var
