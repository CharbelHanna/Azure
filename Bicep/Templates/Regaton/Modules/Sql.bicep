param sql object
param location string

resource sqlsrv_resource 'Microsoft.Sql/servers@2020-11-01-preview' = {
  name: sql.server.name
  location:location
  properties: {
    administratorLogin: sql.server.adminLogin
    administratorLoginPassword: sql.server.adminPassword
    publicNetworkAccess: 'Enabled'
  }
}
var sqlServerURL = '${sqlsrv_resource.name}.${sqlsrv_resource.properties.fullyQualifiedDomainName}'

resource sqldb_resource 'Microsoft.Sql/servers/databases@2020-11-01-preview' = {
  name: '${sql.server.name}/${sql.database.name}'
  location:location
  sku: {
    name:sql.database.sku.name
    tier:sql.database.sku.tier
    capacity:sql.database.sku.capacity
  }
  properties: {
    collation:sql.database.collation
    catalogCollation:sql.database.catalogcollation
    maintenanceConfigurationId:'${subscription().id}/providers/Microsoft.Maintenance/publicMaintenanceConfigurations/SQL_Default'
  }
}
output SqlConnectionString string = 'Server=tcp:${sqlServerURL},1433;InitialCatalog=${sql.database.name};Persist Security Info=False;User ID=${sql.database.adminLogin};Password=${sql.database.adminPass};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;'
