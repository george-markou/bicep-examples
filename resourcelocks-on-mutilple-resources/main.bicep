// Define Target Scope
targetScope = 'subscription'

// Specify the resource names where resource locks are required
param resourceNames array = [
  'rg01'
  'rg02'
  'rg03'
]

// Apply Resource Locks on resources
resource createRgLock 'Microsoft.Authorization/locks@2016-09-01' = [for name in resourceNames: {
  name: name
  properties: {
    level: 'CanNotDelete' //For ReadOnly effect specify the value "ReadOnly"
    notes: 'Resource group should not be deleted.'
}
}]
