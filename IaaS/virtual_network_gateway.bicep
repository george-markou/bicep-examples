// Define VPN Gateway parameters
param VPNGWName string = 'name'
param VPNGWLocation string = 'westeurope'

resource vpngw 'Microsoft.Network/virtualNetworkGateways@2021-02-01' = {
  name: '${VPNGWName}-vpngw'
  location: VPNGWLocation
  properties: {
    sku: {
      name: 'VpnGw1'
      tier: 'VpnGw1'   
    }
    enableBgp: false
  vpnType: 'RouteBased'
  gatewayType: 'Vpn'
  activeActive: false
    }
  }
