param name string

resource createRgLock 'Microsoft.Authorization/locks@2016-09-01' = {
  name: name
  scope: resourceGroup()
  properties: {
    level: 'CanNotDelete'
    notes: 'Resource group should not be deleted.'
  }
}
