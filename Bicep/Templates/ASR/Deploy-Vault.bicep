param vaultName string
param location string
param role string

resource Vault 'Microsoft.RecoveryServices/vaults@2022-01-01' = {
  name: vaultName
  location: location
  properties: {}
  identity: {
    type: 'SystemAssigned'
  }
  sku: {
    name: 'RS0'
    tier: 'Standard'
  }
}

resource roleAssingment 'Microsoft.Authorization/roleAssignments@2020-10-01-preview' = {
  name: guid(resourceGroup().id)
  properties: {
    principalId: Vault.identity.principalId
    principalType:'ServicePrincipal'
    roleDefinitionId: role
  }
}

output vaultID string = Vault.id
output vaultPrincipalID string = Vault.identity.principalId

