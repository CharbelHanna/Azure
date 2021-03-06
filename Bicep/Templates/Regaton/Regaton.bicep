param webApp object
param storageAccount object
param sql object
targetScope = 'subscription'
param location string = deployment().location
resource webapprg 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: webApp.resourcegroupName
  location:location
}
resource sqlrg 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: sql.resourcegroupName
  location:location
}
resource stgrg 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: storageAccount.resourcegroupName
  location:location
}
//modules references---------------------
//calling module by referring to the module name and local path
module StgModule 'Modules/Storage.bicep' = {
  name: 'storageAccountDeploy'
  scope: stgrg
  params: {
    storageAccount:storageAccount
    location:location
  }
}
module SqlModule 'Modules/Sql.bicep' = {
  name: 'SqlDeploy'
  scope: sqlrg
  params: {
    sql: sql
    location:location
  }
}
module WebAppModule 'Modules/Webapp.bicep' = {
  name: 'webAppDeploy'
  scope: webapprg
  params: {
    // passing parameters to specific module
    webapp:webApp
    // passing the output of the storage Module as parameters
    storageEndpoint: StgModule.outputs.storageEndpoint
    storageId: StgModule.outputs.storageId
    sqlConnectionString: SqlModule.outputs.SqlConnectionString
    location:location
  }
}
