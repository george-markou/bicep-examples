targetScope = 'subscription'

param resourceGroups array = [
  'neworg-application-rg'
  'neworg-azmig-rg'
  'neworg-identity-rg'
  'neworg-sharedsvcs-rg'
  'neworg-vnet-rg'
]

param resourceTags object = {
  Application: 'Bicep'
  CostCenter: 'Markou.me'
  Environment: 'Production'
  Owner: 'Markou.me'
}



resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' existing = {
  name: 'neworg-vnet-rg'
}

resource tags 'Microsoft.Resources/tags@2021-04-01' = {
  name: 'default'
  properties: {
    tags: resourceTags
  }
}
