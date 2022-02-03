param variables_virtualNetworkName string /* TODO: fill in correct type */
param variables_subnetProperties object /* TODO: fill in correct type */

@description('Specify Delegated Subnet Name')
param delegatedSubnetName string

resource variables_virtualNetworkName_delegatedSubnetName 'Microsoft.Network/virtualNetworks/subnets@2020-05-01' = {
  name: '${variables_virtualNetworkName}/${delegatedSubnetName}'
  properties: variables_subnetProperties
}
