// Specify VNET custom properties such as Name, IP Address Space and location
param vnetName string = 'myvnet'
param vnetaddressPrefix string = '192.168.0.0/16'
param vnetLocation string = 'westeurope' //Instead of explicit location, the function resourceGroup().location can be used.

// Specify VNET subnet custom properties 
param subnetName1 string = 'mysubnet'
param subnetPrefix1 string = '192.168.0.0/24'
param serviceEndpoint string = 'Microsoft.Storage'


// Create VNET and respective Subnets
resource vnet 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: vnetName
  location: vnetLocation
   properties: {
    addressSpace: {
      addressPrefixes: [
        vnetaddressPrefix
      ]
    }
    subnets: [
      {
        name: subnetName1
        properties: {
          addressPrefix: subnetPrefix1
          serviceEndpoints: [
            {
              service: serviceEndpoint
              locations: [
                vnetLocation
              ]
            }
          ]
        }
      }
    ]
  }
}

