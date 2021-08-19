//targetScope = 'resourceGroup'

param resourceNames array = [
  'samonitortest001'
]

resource createRgLock 'Microsoft.Authorization/locks@2016-09-01' = [for name in resourceNames: {
  name: name
  properties: {
    level: 'CanNotDelete' //For ReadOnly effect specify the value "ReadOnly"
    notes: 'Resource group should not be deleted.'
}
}]
