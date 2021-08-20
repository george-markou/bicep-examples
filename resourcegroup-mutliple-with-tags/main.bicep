// Specify Target Scope, for resource group the preferred scope is 'subscription'
targetScope = 'subscription'

// Specify Resource Group custom properties such as the resource group names and resource tags.
param location string = 'westeurope'
param resourceGroupNames array = [
  'rg01'
  'rg02'
  'rg03'
]
param resourceTags object = {
  Application: 'Bicep'
  CostCenter: 'Marketing'
  Environment: 'Production'
  Owner: 'George Markou'
}

// Create Resource Groups
resource createRG 'Microsoft.Resources/resourceGroups@2021-04-01' = [for name in resourceGroupNames: {
  name: name
  location: location
  tags: resourceTags
}]
