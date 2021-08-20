// Specify storage account custom properties such as the name, type, location, replication option, tier and preferred tags
param storageAccountName string = 'stggm'
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

// Create mutiple storage accounts with unique name
@batchSize(1)
resource stg 'Microsoft.Storage/storageAccounts@2021-04-01' = [for i in range(1,5):{ // Modify range value to reflect the total number of storage accounts to be created, e.g (1,5) will result to 5 storage accounts.
  kind: storageAccountType
  name: '${storageAccountName}${uniqueString(resourceGroup().id)}${i}'
  location: location
  tags: resourceTags
  sku: {
    name: skuName
  }
  properties: {
    accessTier: accessTier
  }
}]
