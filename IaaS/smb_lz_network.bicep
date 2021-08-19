// Define Networking parameters
param hubvnetName string
param vnetaddressPrefix string
param hubsubnetPrefix1 string
param hubsubnetPrefix2 string
param hubsubnetPrefix3 string
param location string
param hubsubnetName1 string
param hubsubnetName2 string
param hubsubnetName3 string
param resourceTags object

//Create Vnet and Subnet
resource hubvnet 'Microsoft.Network/virtualnetworks@2015-05-01-preview' = {
  name: hubvnetName
  location: location
  tags: resourceTags
   properties: {
    addressSpace: {
      addressPrefixes: [
        vnetaddressPrefix
      ]
    }
    subnets: [
      {
        name: hubsubnetName1
        properties: {
          addressPrefix: hubsubnetPrefix1
        }
      }
        {
          name: hubsubnetName2
          properties: {
            addressPrefix: hubsubnetPrefix2
          }
        }
        {
          name: hubsubnetName3
          properties: {
            addressPrefix: hubsubnetPrefix3
          }
        }        
    ]
  }
}
