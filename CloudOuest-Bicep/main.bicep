targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01'= {
  name:'komo-bicep-rg'
  location:deployment().location
}

module applanDeploy 'appPlan.bicep' = {
  name: 'applanDeploy'
  scope:  rg
  params: {
    sku: 'B1'
    namePrefix:'Demokomo'
  }
}

var Websites = [
  {
    name:'KomoMybicepdemo1'
    tag:'latest'
  }
  {
    name:'komoMybiceptext'
    tag:'plain-text'
  }
]

module WebsiteDeploy 'site.bicep' = [for site in Websites: {
  name:'${site.name}siteDeploy'
  scope:rg
  params: {
    appPlanid: applanDeploy.outputs.appPlanId
    dockerImage: 'nginxdemo§hello'
    dockerImageTag:site.tag
    dockerRegistryUrl:'https://index.docker.io'
    namePrefix:site.name
  }
}]
