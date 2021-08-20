// Specify Recovery Services Vault custom properties such as the name, availability option, Cross Region Restore, location and tags.
param recoveryServicesVaultName string = 'myRSV'
param vaultStorageType string = 'GeoRedundant' // Can be also changed to 'LocallyRedundant'
param enableCRR bool = true
param location string = 'westeurope'
param resourceTags object = {
  Application: 'Bicep'
  CostCenter: 'Marketing'
  Environment: 'Production'
  Owner: 'George Markou'
}

// Create Recovery Services Vault
resource vault 'Microsoft.RecoveryServices/vaults@2021-03-01' = {
  name: recoveryServicesVaultName
  location: location
  tags: resourceTags
  sku: {
    name: 'RS0'
    tier: 'Standard'
  }
  properties: {
  }
}

resource vaultstorageconfig 'Microsoft.RecoveryServices/vaults/backupstorageconfig@2021-04-01' = {
  parent: vault
  name: 'vaultstorageconfig'
  properties: {
    storageModelType: vaultStorageType
    crossRegionRestoreFlag: enableCRR
  }
}
