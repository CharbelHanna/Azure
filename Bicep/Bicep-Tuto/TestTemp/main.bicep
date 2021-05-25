resource PubIP 'Microsoft.Network/publicIPAddresses@2020-06-01' = {
  name: 'mytestpublicIP-01'
  location: 'westeurope'
  sku:{
    name: 'Basic'
  }
}


