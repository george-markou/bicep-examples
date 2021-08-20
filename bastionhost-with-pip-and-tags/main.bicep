// Specify Bastion Host custom properties such as the bastion host name, subnet ID of the AzureBastionSubnet and Public IP name
param bastionHostName string = 'bastionhostname'

// As string must specified the resource id of the VNET AzureBastionSubnet subnet
param subnetId string = '/subscriptions/cb7a8f90-5950-4993-ab11-7a3ddf5b7741/resourceGroups/neworg-vnet-rg/providers/Microsoft.Network/virtualNetworks/neworg-vnet/Subnets/AzureBastionSubnet'

param publicIpAddressName string = 'publicipname'
param resourceTags object = {
  Application: 'Bicep'
  CostCenter: 'Marketing'
  Environment: 'Production'
  Owner: 'George Markou'
}

// Create Public IP Address of Bastion Host
resource publicIpAddressName_resource 'Microsoft.Network/publicIpAddresses@2019-02-01' = {
  name: publicIpAddressName
  location: resourceGroup().location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
  tags: resourceTags
}

// Create Bastion Host
resource bastion 'Microsoft.Network/bastionHosts@2020-11-01' = {
  name: bastionHostName
  location: resourceGroup().location
  properties: {
    ipConfigurations: [
      {
        name: 'IpConf'
        properties: {
          subnet: {
            id: subnetId
          }
          publicIPAddress: {
            id: resourceId(resourceGroup().name, 'Microsoft.Network/publicIpAddresses', publicIpAddressName)
          }
        }
      }
    ]
  }
  tags: resourceTags
    dependsOn: [
    publicIpAddressName_resource
   ]
}
