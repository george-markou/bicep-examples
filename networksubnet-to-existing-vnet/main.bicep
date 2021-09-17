// Specify existing VNET name 
param vnetName string = 'existing-vnet'

// Specify VNET subnet custom properties 
param subnetName1 string = 'subnet01'
param subnetPrefix1 string = '10.0.2.0/24'

// Create VNET Subnets
resource vnet 'Microsoft.Network/virtualNetworks@2021-02-01' existing = {
  name: vnetName
}

resource newsubnet 'Microsoft.Network/virtualNetworks/subnets@2021-02-01' = {
  name: subnetName1
  parent: vnet
  properties: {
    addressPrefix: subnetPrefix1
  }
}
