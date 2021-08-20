// Define VNET custom properties such as Name, IP Address Space and Location
param vnetName string = 'sample-vnet'
param vnetaddressPrefix string = '192.168.0.0/16'
param vnetLocation string = 'westeurope' //Instead of explicit location, the function resourceGroup().location can be used.

// Define VNET subnet custom properties 
param subnetName1 string = 'AzureFirewallSubnet'
param subnetPrefix1 string = '192.168.0.0/26'

param subnetName2 string = 'AzureBastionSubnet'
param subnetPrefix2 string = '192.168.0.64/27'

param subnetName3 string = 'GatewaySubnet'
param subnetPrefix3 string = '192.168.0.96/27'

//Create VNET and respective Subnets
resource vnet 'Microsoft.Network/virtualnetworks@2015-05-01-preview' = {
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
        }
      }
      {
        name: subnetName2
        properties: {
          addressPrefix: subnetPrefix2
        }
      }
      {
        name: subnetName3
        properties: {
          addressPrefix: subnetPrefix3
        }
      }
    ]
  }
}
