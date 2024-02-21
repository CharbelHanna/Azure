metadata description = 'AKS Deployment'
metadata Version = '1.0.a'
metadata author = 'Charbel HANNA'

targetScope = 'subscription'

param location string
param aksrgname string

resource aksrg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  location: location
  name: aksrgname
}
