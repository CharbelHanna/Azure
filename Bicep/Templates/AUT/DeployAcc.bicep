// begin params declaration
@description('Automation Account Name')
param automationAccountName string
param location string
param sampleGraphicalRunbookName string = 'AzureAutomationTutorialWithIdentityGraphical'
param sampleGraphicalRunbookDescription string = 'An example runbook which gets all the ARM resources using the Managed Identity.'
param sampleGraphicalRunbookContentUri string = 'https://eus2oaasibizamarketprod1.blob.core.windows.net/marketplace-runbooks/AzureAutomationTutorialNewGraphical.graphrunbook'
param samplePowerShellRunbookName string = 'AzureAutomationTutorialWithIdentity'
param samplePowerShellRunbookDescription string = 'An example runbook which gets all the ARM resources using the Managed Identity.'
param samplePowerShellRunbookContentUri string = 'https://eus2oaasibizamarketprod1.blob.core.windows.net/marketplace-runbooks/AzureAutomationTutorialNew.ps1'

//end params declaration

//start variables declaration
//end variable declaration

//create resources
resource AUT 'Microsoft.Automation/automationAccounts@2021-06-22' = {
  name:automationAccountName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties:{
    sku: {
      name: 'Basic'
    }
    publicNetworkAccess: false
  }
}/**/
  resource SampleGraphicalRunbook 'Microsoft.Automation/AutomationAccounts/runbooks@2019-06-01' = {
    parent:AUT
    name: sampleGraphicalRunbookName
    location: location
    properties: {
      runbookType: 'GraphPowerShell'
      logProgress: false
      logVerbose: false
      description: sampleGraphicalRunbookDescription
      publishContentLink: {

        uri: sampleGraphicalRunbookContentUri
        version: '1.0.0.0'
      }
    }
  }
  resource SamplePowerShellRunbook 'Microsoft.Automation/AutomationAccounts/runbooks@2019-06-01' = {
    parent:AUT
    name: samplePowerShellRunbookName
    location:location
    properties: {
      runbookType: 'PowerShell'
      logProgress: false
      logVerbose: false
      description: samplePowerShellRunbookDescription
      publishContentLink: {
        uri: samplePowerShellRunbookContentUri
        version: '1.0.0.0'
      }
    }
  }

output accID string = AUT.id
