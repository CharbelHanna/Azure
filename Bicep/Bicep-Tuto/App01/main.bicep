//---parameters-----------
param StorageAccountName string
param StorageAccountType string
param StorageAccountSku object

//---variables-----------
var location = resourceGroup().location

//---resources-----------
resource stg 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name:StorageAccountName
  location:location
  kind:StorageAccountType
  sku: {
    name:StorageAccountSku.name
    tier:StorageAccountSku.tier
  }
}
