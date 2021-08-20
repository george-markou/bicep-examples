// Specify Target Scope, for resource group the preferred scope is 'subscription'
targetScope = 'subscription'

// Specify Resource Group custom properties such as resource group name, preferred region and resource tags.
param name string = 'myrg'
param location string = 'westeurope'
param resourceTags object = {
  Application: 'Bicep'
  CostCenter: 'Marketing'
  Environment: 'Production'
  Owner: 'George Markou'
}

// Create Resource Groups
resource createRG 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: name
  location: location
  tags: resourceTags
}
