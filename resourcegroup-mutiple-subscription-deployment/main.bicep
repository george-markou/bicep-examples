targetScope = 'managementGroup'

param location string = 'westeurope'
param resourceName1 string = 'myrg-01'
param resourceName2 string = 'myrg-02'
param subscription01 string = 'cb7a8f90-5950-4993-ab11-xxxxxxxxxxxx'
param subscription02 string = '662004f2-f222-41b8-b465-xxxxxxxxxxxx'



module rg './module-resourcegroup.bicep' = {
  name: resourceName1
  scope: subscription(subscription01)
  params: {
    location: location
    resourceGroupName: resourceName1
  }
}

module rg2 './module-resourcegroup.bicep' = {
  name: resourceName2
  scope: subscription(subscription02)
  params: {
    location: location
    resourceGroupName: resourceName2
  }
}
