param recoveryServicesVaultName string
param location string
param resourceTags object

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
