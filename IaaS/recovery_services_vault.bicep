param namePrefix string = 'namePrefix'
var RecoveryServicesVaultName = '${namePrefix}-rsv'

resource vault 'Microsoft.RecoveryServices/vaults@2021-03-01' = {
  name: RecoveryServicesVaultName
  location: 'westeurope'
  sku: {
    name: 'RS0'
    tier: 'Standard'
  }
  properties: {}
}
