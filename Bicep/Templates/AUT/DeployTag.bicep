


resource mytag 'Microsoft.Resources/tags@2021-04-01' = {
  name: 'default'
  properties: {
    tags: {
      marketplaceItemId: 'Microsoft.ApplicationSecurityGroup'
    }
  }
}
