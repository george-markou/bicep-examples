// Specify Hub VNET custom properties such as location, vnet name, ip address space, subnet names and prefixes
param hubvnetName string = 'myhubvnet'
param hubsubnetName1 string = 'AzureFirewallSubnet'
param hubsubnetName2 string = 'GatewaySubnet'
param hubsubnetName3 string = 'AzureBastionSubnet'
param hubvnetaddressPrefix string = '10.0.0.0/16'
param firewallsubnetPrefix string = '10.0.0.0/26'
param gatewaysubnetPrefix string = '10.0.0.128/26'
param bastionsubnetPrefix string = '10.0.1.0/27'

// Specify Spoke VNET custom properties such as location, vnet name, ip address space, subnet names and prefixes
param spokevnetName string = 'myspokevnet'
param spokevnetaddressPrefix string = '10.1.0.0/16'
param spokesubnetName string = 'spoke-snet'
param spokesubnetPrefix string = '10.1.0.0/24'
param serviceEndpoint string = 'Microsoft.Storage'


// Specify deployment common properties
param resourceTags object = {
  Application: 'Bicep'
  CostCenter: 'Marketing'
  Environment: 'Production'
  Owner: 'George Markou'
}
param enableDdosProtection bool = false
param location string = 'westeurope'

//Create Hub VNET and Subnets
resource hubvnet 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: hubvnetName
  location: location
  tags: resourceTags
  properties: {
    addressSpace: {
      addressPrefixes: [
        hubvnetaddressPrefix
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

// Create Spoke VNET
resource spokevnet 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: spokevnetName
  location: location
  tags: resourceTags
  properties: {
    addressSpace: {
      addressPrefixes: [
        spokevnetaddressPrefix
      ]
    }
    subnets: [
      {
        name: spokesubnetName
        properties: {
          addressPrefix: spokesubnetPrefix
          serviceEndpoints: [
            {
              service: serviceEndpoint
              locations: [
                location
              ]
            }
          ]
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
    enableDdosProtection: enableDdosProtection
  }
}

// Create VNET peering betweer hubvnet and spoke
resource VnetPeering1 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-05-01' = {
  parent: hubvnet
  name: 'peer-${hubvnetName}-${spokevnetName}'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: spokevnet.id
    }
  }
}

// Create VNET peering between spoke and hubvnet
resource VnetPeering2 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-05-01' = {
  parent: spokevnet
  name: 'peer-${spokevnetName}-${hubvnetName}'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: hubvnet.id
    }
  }
}
