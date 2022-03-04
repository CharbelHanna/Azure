targetScope = 'subscription'

param location string = deployment().location

// start params declaration
@description('The Automation Account Name')
param automationAccountName string 

@description('resource group name')
param existingRGName string

@description('Vnet Name')
param existingVNETName string

@description('Existing Subnet Name')
param ExistingSUBNETName string 

@description('Existing Vnet Resource Group Name')
param ExistingVNETRGName string

@description('Private Link Sub Resource')
@allowed([
  'Webhook'
  'DSCAndHybridWorker'
])
param privatelinkSubResource string
// end params declaration


//fecthing existing resources objects
resource DeploymentRG 'Microsoft.Resources/resourceGroups@2021-04-01' existing = {
name: existingRGName
}

resource VnetRG 'Microsoft.Resources/resourceGroups@2021-04-01' existing = {
name:ExistingVNETRGName
}

//calling modules
module DeployTag 'DeployTag.bicep' = {
  name:'DeployAppSecurityGroupTag'
  scope: DeploymentRG
}

module DeployAcc 'DeployAcc.bicep' = {
  name:'DeployAcc-${uniqueString(DeploymentRG.id)}'
  scope: DeploymentRG
  params: {
    automationAccountName:automationAccountName
    location:location
  }
}

module GetSub 'DeploySub.bicep' = {
  name: 'GetSub-${uniqueString(VnetRG.id)}'
  scope:VnetRG
  params: {
    ExistingSubnetName: ExistingSUBNETName
    existingVnetName: existingVNETName
  }
}

module DeployPE 'DeployPE.bicep' = {
  name:'DeployPE-${uniqueString(VnetRG.id)}'
  scope: VnetRG
  params: {
    location:location
    subnetID: GetSub.outputs.subnetID
    subnetName: ExistingSUBNETName
    subnetProperties: GetSub.outputs.subnetProperties
    existingVnetName: existingVNETName
    automationAccountName:automationAccountName
    privatelinkserviceId:DeployAcc.outputs.accID
    privatelinkSubResource: privatelinkSubResource
    
  }
}
