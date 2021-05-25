//---parameters-----------
param storageAccount object
param location string

var storageAccountName = '${storageAccount.namePrefix}-${uniqueString(resourceGroup().id)}'
//---resources-----------
resource stg 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name:storageAccountName
  location:location
  kind:storageAccount.type
  sku: {
    name:storageAccount.Sku.name
    tier:storageAccount.Sku.tier
  }
}
output storageEndpoint object = stg.properties.primaryEndpoints
output storageId string = stg.id
