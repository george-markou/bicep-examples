// Specify Hub VNET custom properties such as location, vnet name, ip address space, subnet names, prefixes and tags
param location string = 'westeurope'
param hubvnetName string = 'myhubvnet'
param hubsubnetName1 string = 'AzureFirewallSubnet'
param hubsubnetName2 string = 'GatewaySubnet'
param hubsubnetName3 string = 'AzureBastionSubnet'
param vnetaddressPrefix string = '10.0.0.0/16'
param firewallsubnetPrefix string = '10.0.0.0/26'
param gatewaysubnetPrefix string = '10.0.0.128/26'
param bastionsubnetPrefix string = '10.0.1.0/27'
param enableDdosProtection bool = false
param resourceTags object = {
  Application: 'Bicep'
  CostCenter: 'Marketing'
  Environment: 'Production'
  Owner: 'George Markou'
}

//Create Hub VNET and Subnets
resource hubvnet 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: hubvnetName
  location: location
  tags: resourceTags
   properties: {
    addressSpace: {
      addressPrefixes: [
        vnetaddressPrefix
      ]
    }
    subnets: [
      {
        name: hubsubnetName1
        properties: {
          addressPrefix: firewallsubnetPrefix
        }
      }
        {
          name: hubsubnetName2
          properties: {
            addressPrefix: gatewaysubnetPrefix
          }
        }
        {
          name: hubsubnetName3
          properties: {
            addressPrefix: bastionsubnetPrefix
          }
        }        
    ]
    enableDdosProtection: enableDdosProtection
  }
}
