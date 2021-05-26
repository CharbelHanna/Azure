param webapp object
param storageEndpoint object
param storageId string
param sqlConnectionString string
param location string

var webappName = '${webapp.namePrefix}${uniqueString(resourceGroup().id)}'
var hostingPlanName = '${webappName}-Hostingplan'

resource webapp_resource 'Microsoft.Web/sites@2020-12-01' = {
  name: webapp.name
  location:location
  tags: null
  properties: {
    siteConfig: {
      appSettings: [
        //defining connection to storage accounts
        {
          name: 'AzureBlobStorage'
          value: 'DefaultEndpointsProtocol=https;${storageEndpoint};AccountKey=${listKeys(storageId, '2021-02-01').keys[0].value}'
        }
      ]
      connectionStrings: [
        //defining connection to the sql databases
        {
          name: 'sqldbconnection'
          connectionString: sqlConnectionString
          type: 'SQLServer'
        }
      ]
      linuxFxVersion: webapp.linuxFxVersion
      alwaysOn: webapp.alwaysOn
    }
    serverFarmId: hostingPlan_resource.id
    clientAffinityEnabled: false
  }
}
resource hostingPlan_resource 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: hostingPlanName
  location: resourceGroup().location
  kind: 'linux'
  tags: null
  sku: {
    name: webapp.skuCode
    family: webapp.skuFamily
    tier: webapp.sku
    size: webapp.skuSize
    capacity: webapp.skuCapacity
  }
}
