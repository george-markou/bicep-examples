// Specify Public IP Address custom properties such as name, location and resource tags 
param pipName string = 'mypip'
param location string = 'westeurope'
param resourceTags object = {
  Application: 'Bicep'
  CostCenter: 'Marketing'
  Environment: 'Production'
  Owner: 'George Markou'
}

// Create Public IP Address
resource vm01pip 'Microsoft.Network/publicIPAddresses@2021-02-01' = {
  name: pipName
  location: location
  tags: resourceTags
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
    }
  }
