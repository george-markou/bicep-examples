param RecoveryServicesVaultName string = 'bicep'

resource vault 'Microsoft.RecoveryServices/vaults@2021-03-01' = {
  name: '${RecoveryServicesVaultName}-rsv'
  location: 'westeurope'
  sku: {
    name: 'RS0'
    tier: 'Standard'
  }
  properties: {}
}
