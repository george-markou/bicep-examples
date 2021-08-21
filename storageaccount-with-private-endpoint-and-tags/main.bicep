// Specify custom properties such as the name, type, location, replication option, tier, VNET, subnet, PrivateDNS Zone and preferred tags
param storageAccountName string = 'stgbicep'
param storageAccountType string = 'StorageV2'
param location string = 'westeurope'
param skuName string = 'Standard_LRS'
param accessTier string = 'Hot'
param vnetName string = 'neworg-vnet' // E.g of an existing VNET
param subnetName string = 'ApplicationSubnet' // E.g of an existing subnet contained in VNET that specified in previous parameter
param iphostAllowed string = '8.8.8.8' // E.g of an IP host that is allowed to connect to storage account for management
param privateEndpointName string = 'privateEndpoint${uniqueString(resourceGroup().name)}'
param privateLinkConnectionName string = 'privateLink${uniqueString(resourceGroup().name)}'
param privateDNSZoneName string = 'privatelink.blob.core.windows.net'
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

// Enable service endpoints on existing subnet
resource subnet 'Microsoft.Network/virtualNetworks/subnets@2021-02-01' = {
  name: '${vnetName}/${subnetName}'
  properties: {
    addressPrefix: '10.0.2.0/24'
    privateEndpointNetworkPolicies: 'Disabled'
    serviceEndpoints: [
      {
        service: 'Microsoft.Storage'
      }
    ]
  }
}

// Create Storage Account
resource stg 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  kind: storageAccountType
  name: '${storageAccountName}${uniqueString(resourceGroup().id)}'
  location: location
  tags: resourceTags
  sku: {
    name: skuName
  }
  properties: {
    accessTier: accessTier
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      resourceAccessRules: [
      ]
      bypass: 'AzureServices'
      virtualNetworkRules: [
        {
            id: '${subnet.id}'
            action: 'Allow'
            state: 'Succeeded'
        }
      ]
      ipRules: [
        {
          value: iphostAllowed
          action: 'Allow'
        }
      ]
      defaultAction: 'Deny'
    }
  }
}

//Create Private Endpoint
resource privateEndpoint 'Microsoft.Network/privateEndpoints@2020-06-01' = {
  name: privateEndpointName
  location: location
  properties: {
    subnet: {
      id: subnet.id
    }
    privateLinkServiceConnections: [
      {
        name: privateLinkConnectionName
        properties: {
          privateLinkServiceId: stg.id
          groupIds: [
            'blob'
          ]
        }
      }
    ]
  }
}

// Create Private DNS Zone
resource privateDNSZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: privateDNSZoneName
  location: 'global'
}

// Create Virtual Network Link for Private DNS Zone
resource virtualNetworkLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  name: '${privateDNSZone.name}/${privateDNSZone.name}-link'
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: vnet.id
    }
  }
}

// Create Private DNS Zone Group
resource privateDNSZoneGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2020-06-01' = {
  name: '${privateEndpoint.name}/dnsgroupname'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'config1'
        properties: {
          privateDnsZoneId: privateDNSZone.id
        }
      }
    ]
  }
}
