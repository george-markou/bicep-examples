param StorageAccountName string
param location string
param skuName string
param resourceTags object

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  kind: 'StorageV2'
  name: StorageAccountName
  location: location
  tags: resourceTags
  sku: {
    name: skuName
  }
}
