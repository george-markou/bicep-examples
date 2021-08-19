// Define VPN Gateway parameters
param VPNGWName string
param VPNGWpip string
param location string
param vnetName string 
param gatewaysubnetName string
param rgnetw string
param vpnType string
param resourceTags object

resource vpngwpip 'Microsoft.Network/publicIPAddresses@2021-02-01' = {
  name: VPNGWpip
  location: location
  tags: resourceTags
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}

resource vpngw 'Microsoft.Network/virtualNetworkGateways@2021-02-01' = {
  name: VPNGWName
  location: location
  tags: resourceTags
  properties: {
    sku: {
      name: 'VpnGw1'
      tier: 'VpnGw1'   
    }
  ipConfigurations: [
    {
      name: 'default'
      properties: {
        privateIPAllocationMethod: 'Dynamic'
        subnet: {
          id: resourceId(rgnetw, 'Microsoft.Network/virtualNetworks/subnets', vnetName, gatewaysubnetName)
        }
        publicIPAddress: {
          id: resourceId(rgnetw, 'Microsoft.Network/publicIPAddresses', VPNGWpip)
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
