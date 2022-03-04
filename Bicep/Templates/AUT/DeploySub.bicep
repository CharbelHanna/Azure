
//params
@description('name of the existing Subnet')
param ExistingSubnetName string

@description('existing Vnet Name')
param existingVnetName string

//variables
var existingSubName = '${existingVnetName}/${ExistingSubnetName}'

resource ExistingVnet 'Microsoft.Network/virtualNetworks@2021-05-01' existing = {
  name:existingVnetName
}

resource ExistingSubnet 'Microsoft.Network/virtualNetworks/subnets@2021-05-01' existing = {
  name: existingSubName
}

output subnetProperties object = ExistingSubnet.properties
output subnetID string = ExistingSubnet.id
