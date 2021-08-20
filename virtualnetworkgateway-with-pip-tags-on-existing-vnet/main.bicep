// Specify VPN Gateway custom properties such as GW name, pip, VNET name, VPN Type, SKU Name/Tier and resource tags 
param VPNGWName string = 'myvpng'
param VPNGWpip string = 'myvpng-pip'
param vnetName string = 'my-vnet'
param gatewaysubnetName string = 'GatewaySubnet'
param vpnType string = 'RouteBased' // OR PolicyBased
param skuName string = 'VpnGw1'
param skuTier string = 'VpnGw1'
param resourceTags object = {
  Application: 'Bicep'
  CostCenter: 'Marketing'
  Environment: 'Production'
  Owner: 'George Markou'
}

// Create VPNGW Public IP Address
resource vpngwpip 'Microsoft.Network/publicIPAddresses@2021-02-01' = {
  name: VPNGWpip
  location: resourceGroup().location
  tags: resourceTags
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}

// Create VPNGW
resource vpngw 'Microsoft.Network/virtualNetworkGateways@2021-02-01' = {
  name: VPNGWName
  location: resourceGroup().location
  tags: resourceTags
  properties: {
    sku: {
      name: skuName
      tier: skuTier   
    }
  ipConfigurations: [
    {
      name: 'default'
      properties: {
        privateIPAllocationMethod: 'Dynamic'
        subnet: {
          id: resourceId(resourceGroup().name, 'Microsoft.Network/virtualNetworks/subnets', vnetName, gatewaysubnetName)
        }
        publicIPAddress: {
          id: resourceId(resourceGroup().name, 'Microsoft.Network/publicIPAddresses', VPNGWpip)
        }
      }
    }
  ]  
  enableBgp: false
  vpnType: vpnType
  gatewayType: 'Vpn'
  activeActive: false
  vNetExtendedLocationResourceId: ''
    }
    dependsOn: [
      vpngwpip
    ]
  }
