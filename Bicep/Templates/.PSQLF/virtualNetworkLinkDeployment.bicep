param variables_privateDnsZoneName string /* TODO: fill in correct type */

@description('Virtual NetworkId to integrate the application')
param virtualNetworkId string

resource variables_privateDnsZoneName_virtualNetworkId 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  name: '${variables_privateDnsZoneName}/${uniqueString(virtualNetworkId)}'
  location: 'global'
  properties: {
    virtualNetwork: {
      id: virtualNetworkId
    }
    registrationEnabled: false
  }
}
