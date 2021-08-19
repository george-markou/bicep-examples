param automationAccountName string
param resourceTags object
param location string

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
