param sql object
param location string

resource sqlsrv_resource 'Microsoft.Sql/servers@2020-11-01-preview' = {
  name: sql.serverName
  location:location
  properties: {
    administratorLogin: sql.adminLogin
    administratorLoginPassword: sql.adminPassword
    publicNetworkAccess: 'Enabled'
  }
}
var sqlServerURL = '${sqlsrv_resource.name}.${sqlsrv_resource.properties.fullyQualifiedDomainName}'

resource sqldb_resource 'Microsoft.Sql/servers/databases@2020-11-01-preview' = {
  name: '${sqlsrv_resource.name}/${sql.databaseName}'
  location:location
  sku: {
    name:sql.sku.name
    tier:sql.sku.tier
    capacity:sql.sku.capacity
  }
  properties: {
    collation:sql.collation
    catalogCollation:sql.catalogcollation
    maintenanceConfigurationId:'${subscription().id}/providers/Microsoft.Maintenance/publicMaintenanceConfigurations/SQL_Default'
  }
}
output SqlConnectionString string = 'Server=tcp:${sqlServerURL},1433;InitialCatalog=${sql.databaseName};Persist Security Info=False;User ID=${sql.adminLogin};Password=${sql.adminPassword};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;'
