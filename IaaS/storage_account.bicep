//Define storage account custom properties
param storageAccountName string = 'corplz'
param storageAccountKind string = 'StorageV2'
param location string = 'westeurope'
param skuName string = 'Standard_LRS'
param accessTier string = 'Hot'
/* param resourceTags object = {
  Application: 'LOB App'
  CostCenter: 'Markou.me'
  Environment: 'Production'
  Owner: 'George Markou'
}
*/

//Deploy storage account
@batchSize(1)
resource stg 'Microsoft.Storage/storageAccounts@2021-04-01' = [for i in range(1,1):{
  kind: storageAccountKind
  name: 'sa${storageAccountName}${uniqueString(resourceGroup().id)}${i}'
  location: location
  //tags: resourceTags
  sku: {
    name: skuName
  }
  properties: {
    accessTier: accessTier
  }
}]
