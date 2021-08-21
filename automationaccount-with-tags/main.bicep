// Specify Automation Account custom properties such as name,location and resource tags
param automationAccountName string = 'myaa'
param location string = 'westeurope'
param resourceTags object = {
  Application: 'Bicep'
  CostCenter: 'Marketing'
  Environment: 'Production'
  Owner: 'George Markou'
}

// Create Automation Account
resource aaccount 'Microsoft.Automation/automationAccounts@2019-06-01' = {
name: automationAccountName
tags: resourceTags
location: location
properties: {
  sku: {
    name: 'Basic'
  }
}
}
