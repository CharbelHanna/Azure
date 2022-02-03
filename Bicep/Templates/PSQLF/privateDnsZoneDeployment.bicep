param variables_privateDnsZoneName ? /* TODO: fill in correct type */

resource variables_privateDnsZoneName_resource 'Microsoft.Network/privateDnsZones@2018-09-01' = {
  name: variables_privateDnsZoneName
  location: 'global'
  properties: {}
}