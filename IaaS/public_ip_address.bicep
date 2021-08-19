// description
//param publicIpName1 string = 'pip-fgt-01'
param location string = 'westeurope'
param publicIPAllocationMethod string = 'Static'
param publicIpSku string = 'Standard'
param publicIPNames array = [
  'pip-netmotion-01'
  'pip-netmotion-02'
]

resource publicIP 'Microsoft.Network/publicIPAddresses@2020-06-01' = [for name in publicIPNames: {
  name: name
  location: location
  sku: {
    name: publicIpSku
  }
  properties: {
    publicIPAllocationMethod: publicIPAllocationMethod
  }
}]

output publicIPName array = [for (name, i) in publicIPNames: {
  name: publicIP[i].name
  resourceId: publicIP[i].id
}]
