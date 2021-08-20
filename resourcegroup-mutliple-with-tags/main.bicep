// Define Target Scope, for resource group the preferred scope is 'subscription'
targetScope = 'subscription'

// Defince Resource Group custom properties such as the resource group names and resource tags.
param location string = 'westeurope'
param resourceGroupNames array = [
  'rg01'
  'rg02'
  'rg03'
]
param resourceTags object = {
  Application: 'Bicep'
  CostCenter: 'Markou.me'
  Environment: 'Production'
  Owner: 'Markou.me'
}

resource createRG 'Microsoft.Resources/resourceGroups@2021-04-01' = [for name in resourceGroupNames: {
  name: name
  location: location
  tags: resourceTags
}]
