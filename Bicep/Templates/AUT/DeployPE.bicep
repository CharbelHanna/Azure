//start params declaration
@description('Deployment location')
param location string
@description('Service Name')
param automationAccountName string 
@description('resource id to be linked to')
param privatelinkSubResource string
@description('private link sub resource')
param privatelinkserviceId string
@description('The Name of the Private DNS Zone')
param PrivateDnsZoneName string  = 'privatelink.azure-automation.net'
@description('existing Vnet Name')
param existingVnetName string
@description('name of the existing Subnet')
param subnetName string
@description('Existing Subnet Resource ID')
param subnetID string
@description('Existing Subnet Object')
param subnetProperties object
//End Prarams declaration



// start variables declaration
var existingSubName = '${existingVnetName}/${subnetName}'
var privateEndpointName = '${automationAccountName}-pe-${uniqueString(resourceGroup().id)}'
// end variables declaration

// fetching existing resources objects
 
resource ExistingVnet 'Microsoft.Network/virtualNetworks@2021-05-01' existing = {
  name:existingVnetName
}
// end of fectching

// update and create resources
resource updateSubnetConfig 'Microsoft.Network/virtualNetworks/subnets@2021-05-01' = { // update the existing subnet privateEndpoint Network Polices
  name: existingSubName
  properties: {
    addressPrefix:subnetProperties.addressPrefix
    networkSecurityGroup:subnetProperties.networkSecurityGroup
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}
resource PDZ 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  location:'global'
  name:PrivateDnsZoneName
}
resource Pdzlink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  location:'global'
  parent: PDZ
  name: uniqueString(resourceGroup().id)
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: ExistingVnet.id
    }
  }
}
resource privateEndpoint 'Microsoft.Network/privateEndpoints@2021-05-01' = {
  name: privateEndpointName
  location: location
  properties: {
    subnet: {
      id: subnetID
    }
    privateLinkServiceConnections: [
      {
        name: '${privateEndpointName}-link'
        properties: {
          privateLinkServiceId: privatelinkserviceId
          groupIds: [
            privatelinkSubResource
          ]
        }
      }
    ]
  }
}
resource PDZGroups 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2021-05-01'={
  parent: privateEndpoint
  name: 'default'
  properties: {
    privateDnsZoneConfigs: [
     {
       name: privateEndpoint.name
       properties: {
         privateDnsZoneId: PDZ.id
       }
     }
    ]
  }
}
