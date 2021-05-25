//parameters--------------------

param webapp object
param storageAccount object
param sql object
//param location string = deployment().location
targetScope = 'subscription'

//create resource groups


resource webapprg 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: webapp.resourcegroupName
  location:'westeurope'
}
resource sqlrg 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: sql.resourcegroupName
  location:'westeurope'
}
resource stgrg 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: storageAccount.resourcegroupName
  location:'westeurope'
}

//modules references ---------------------
//calling module by referring to the module name and local path
module WebAppModule 'Modules/Webapp.bicep' = {
  name: 'webAppDeploy'
  scope: webapprg
  params: {
    // passing parameters to specific module
    webapp: webapp
    // passing the output of the storage Module as parameters
    storageEndpoint: StgModule.outputs.storageEndpoint
    storageId: StgModule.outputs.storageId
    sqlConnectionString: SqlModule.outputs.SqlConnectionString
    location:'westeurope'
  }
}
module StgModule 'Modules/Storage.bicep' = {
  name: 'storageAccountDeploy'
  scope: stgrg
  params: {
    storageAccount: storageAccount
    location:'westeurope'
  }
}

module SqlModule 'Modules/Sql.bicep' = {
  name: 'SqlDeploy'
  scope: sqlrg
  params: {
    sql: sql
    location:'westeurope'
  }
}
