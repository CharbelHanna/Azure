
param routeTableName string = 'ZHSRoute'
param existingLockName string = 'ReadOnlyLock'


 resource routetable 'Microsoft.Network/routeTables@2021-05-01'={
  name: routeTableName
  location: resourceGroup().location
  properties:{
    disableBgpRoutePropagation: true
  }
  
  }


