
//Start Params
@description('The Name of the Private DNS Zone')
param PrivateDnsZoneName string  = 'privatelink-azure-automation-net'

@description('existing Vnet Name')
param ExistingVnetName string

//End Prarams


//params
@description('name of the existing Subnet')
param ExistingSubnetName string

//variables
var ExistingSubName = '${ExistingVnetName}/${ExistingSubnetName}'

resource ExsitingSubnet 'Microsoft.Network/virtualNetworks/subnets@2021-05-01' existing = {
  name: ExistingSubName
}

resource updateSubnetConfig 'Microsoft.Network/virtualNetworks/subnets@2021-05-01' = {
  name: ExsitingSubnet.name
  properties: {
    addressPrefix: ExsitingSubnet.properties.addressPrefix
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'

  }
}

resource ExistingVnet 'Microsoft.Network/virtualNetworks@2021-05-01' existing = {
  name:ExistingVnetName
}

resource PDZ 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name:PrivateDnsZoneName
}
resource Pdzlink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: PDZ
  name: uniqueString(resourceGroup().id)
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: ExistingVnet.id
    }
  }
}
output PrivateDnsZoneID string = PDZ.id
output SubnetId string = ExsitingSubnet.id
// output VnetId string = ExistingVnet.id
