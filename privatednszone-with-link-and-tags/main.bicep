// Specify Private DNS Zone custom properties
param vnetName string = 'neworg-vnet' // E.g of an existing VNET
param privateDNSZoneName string = 'myzone.local'
param resourceTags object = {
  Application: 'Bicep'
  CostCenter: 'Marketing'
  Environment: 'Production'
  Owner: 'George Markou'
}

// Specify existing VNET
resource vnet 'Microsoft.Network/virtualNetworks@2021-02-01' existing = {
  name: vnetName
}

// Create Private DNS Zone
resource privateDNSZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: privateDNSZoneName
  tags: resourceTags
  location: 'global'
}

// Create Virtual Network Link for Private DNS Zone
resource virtualNetworkLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  name: '${privateDNSZone.name}/${privateDNSZone.name}-link'
  location: 'global'
  tags: resourceTags
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: vnet.id
    }
  }
}
