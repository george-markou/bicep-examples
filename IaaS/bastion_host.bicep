param location string = 'westeurope'
param resourceGroup string = 'prod-net-rg'
param bastionHostName string = 'prod-bas-01'
param subnetId string = 'AzureBastionSubnet'
param bastionHostSku string = 'Basic'
/* param bastionHostScaleUnits string = '2'    */
param publicIpAddressName string = 'prod-bastion-pip'

resource publicIpAddressName_resource 'Microsoft.Network/publicIpAddresses@2019-02-01' = {
  name: publicIpAddressName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
  tags: {}
}

resource bastionHostName_resource 'Microsoft.Network/bastionHosts@2020-11-01' = {
  name: bastionHostName
  sku: {
    name: bastionHostSku
  }
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'IpConf'
        properties: {
          subnet: {
            id: subnetId
          }
          publicIPAddress: {
            id: resourceId(resourceGroup, 'Microsoft.Network/publicIpAddresses', publicIpAddressName)
          }
        }
      }
    ]
  }
}
