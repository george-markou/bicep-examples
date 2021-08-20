// Specify storage account custom properties such as the name, type, location, replication option, tier and preferred tags
param storageAccountName string = 'somethingunique'
param storageAccountType string = 'StorageV2'
param location string = 'westeurope'
param skuName string = 'Standard_LRS'
param accessTier string = 'Hot'
param resourceTags object = {
  Application: 'Bicep'
  CostCenter: 'Marketing'
  Environment: 'Production'
  Owner: 'George Markou'
}

// Deploy storage account
resource stg 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  kind: storageAccountType
  name: storageAccountName
  location: location
  tags: resourceTags
  sku: {
    name: skuName
  }
  properties: {
    accessTier: accessTier
  }
}
