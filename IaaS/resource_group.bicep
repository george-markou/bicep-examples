// This is where you define the target scope
targetScope = 'subscription'

// This is where you define reusable parameters
param ResourceGroupName string = 'testbicep'
param dateTime string = utcNow('d')
param resourceTags object = {
  Application: 'Not-Defined'
  CostCenter: 'Not-Defined'
  CreationDate: dateTime
  Environment: 'Production'
  Owner: 'Markou.me'
}


// This is where you describe your azure resource 
resource rg1'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${ResourceGroupName}01-rg'
  location : 'westeurope'
  tags: resourceTags
}

// This is where you describe your azure resource 
resource rg2 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${ResourceGroupName}02-rg'
  location : 'westeurope'
  tags: resourceTags
}

module createRgLock1 './resource_lock_module.bicep' = {
  name: 'CanNotDelete'
  scope: resourceGroup(rg1.name)
  params: {
    name: 'CanNotDelete'
  }
}

module createRgLock2 './resource_lock_module.bicep' = {
  name: 'CanNotDelete'
  scope: resourceGroup(rg2.name)
  params: {
    name: 'CanNotDelete'
  }
  dependsOn: [
    rg1
  ]
}
