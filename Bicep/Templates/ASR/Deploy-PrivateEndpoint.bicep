param vaultID string
param PrivateEndpointName string
param VirtualNetworkId string
param ExistingSUBNETName string
param vaultPrincipalID string
param location string
param role string

var PrivateDNSZoneNames = [
  'privatelink.we.backup.windowsazure.com'
  'privatelink.blob.core.windows.net'
  'privatelink.queue.core.windows.net'
]
var privateDnsZoneConfigsNames = [
  'privatelink-we-backup-windowsazure-com'
  'privatelink-blob-core-windows-net'
  'privatelink-queue-core-windows-net'
]


resource roleAssingment 'Microsoft.Authorization/roleAssignments@2020-10-01-preview' = {
  name: guid(resourceGroup().id)
  properties: {
    principalId: vaultPrincipalID
    principalType: 'ServicePrincipal'
    roleDefinitionId: role
  }
}

resource PrivateEndpoint 'Microsoft.Network/privateEndpoints@2021-05-01' = {
  name: PrivateEndpointName
  dependsOn: [
    roleAssingment
  ]
  location: location
  tags: {}
  properties: {
    privateLinkServiceConnections: [
      {
        name: '${PrivateEndpointName}-${uniqueString(resourceGroup().id)}'
        properties: {
          privateLinkServiceId: vaultID
          groupIds: [
            'AzureBackup'
          ]
          privateLinkServiceConnectionState: {
            status: 'Approved'
            description: 'Auto-Approved'
            actionsRequired: 'None'
          }
        }
      }
    ]
    subnet: {
      id: '${VirtualNetworkId}/subnets/${ExistingSUBNETName}'
    }
    customDnsConfigs: []
  }
}

resource PrivateDNSZones 'Microsoft.Network/privateDnsZones@2018-09-01' = [for i in range(0, length(PrivateDNSZoneNames)): {
  name: PrivateDNSZoneNames[i]
  location: 'global'
  tags: {}
  properties: {}
}]

resource virtualNetworkLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2018-09-01' = [for j in range(0, length(PrivateDNSZoneNames)): {
  name: '${PrivateDNSZoneNames[j]}/${uniqueString(VirtualNetworkId)}'
  location: 'global'
  properties: {
    virtualNetwork: {
      id: VirtualNetworkId
    }
    registrationEnabled: false
  }
}]

resource PrivateDnsZoneGroups 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2021-03-01' = {
  parent: PrivateEndpoint
  name: 'default'
  properties: {
    privateDnsZoneConfigs: [for u in range(0, length(PrivateDNSZoneNames)): {
      name: privateDnsZoneConfigsNames[u]
      properties: {
        privateDnsZoneId: PrivateDNSZones[u].id
      }
    }]
  }
}

