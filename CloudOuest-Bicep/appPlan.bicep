param sku string = 'B1'
param namePrefix string

resource appPlan 'Microsoft.Web/serverfarms@2021-01-01' = {
  name:'${namePrefix}MyDemoApplan'
  location:resourceGroup().location
  kind:'linux'
  sku:{
    name: sku 
  }
  properties: {
    reserved:true
  }
}

output appPlanId string = appPlan.id

