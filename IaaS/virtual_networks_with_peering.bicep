// Define HUB VNET parameters Name, IP Address Space and Location
param vnetName1 string = 'hub-vnet'
param vnetaddressPrefix string = '192.168.0.0/16'
param vnetLocation string = 'westeurope'

// Define HUB VNET Subnets parameters
param subnetName1 string = 'AzureFirewallSubnet'
param subnetPrefix1 string = '192.168.0.0/24'

param subnetName2 string = 'BastionSubnet'
param subnetPrefix2 string = '192.168.1.0/24'

param subnetName3 string = 'GatewaySubnet'
param subnetPrefix3 string = '192.168.2.0/26'

// Define Spoke 1 VNET parameters Name, IP Address Space and Location
param vnetName2 string = 'spoke-vnet1'
param vnet2addressPrefix string = '172.16.0.0/16'
param vnet2Location string = 'westeurope'

// Define Spoke 1 VNET Subnets parameters
param vnet2subnetName1 string = 'Subnet1'
param vnet2subnetPrefix1 string = '172.16.0.0/24'


//Create HUB VNET and its Subnets
resource hunbvnet 'Microsoft.Network/virtualnetworks@2015-05-01-preview' = {
  name: vnetName1
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

//Create HUB VNET and its Subnets
resource spokevnet 'Microsoft.Network/virtualnetworks@2015-05-01-preview' = {
  name: vnetName2
  location: vnet2Location
   properties: {
    addressSpace: {
      addressPrefixes: [
        vnet2addressPrefix
      ]
    }
    subnets: [
      {
        name: vnet2subnetName1
        properties: {
          addressPrefix: vnet2subnetPrefix1
        }  
      }
    ]
  }
}

resource peerings 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2021-02-01' = {
name: '${vnetName1}to${vnetName2}'
properties: {
remoteAddressSpace: 
}
}
