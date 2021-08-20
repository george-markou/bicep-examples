// Specify AVD Workspace and Host pools custom properties such as name,location and resource tags.
param avdwksName string = 'myavdworkspace'
param avdfirstpool string = 'myfirsthostpool'
param avdsecondpool string = 'mysecondpool'
var location = resourceGroup().location
param resourceTags object = {
  Application: 'Bicep'
  CostCenter: 'Marketing'
  Environment: 'Production'
  Owner: 'George Markou'
}

// Create AVD Workspace 
resource avdwks 'Microsoft.DesktopVirtualization/workspaces@2021-03-09-preview' = {
  name: avdwksName
  tags: resourceTags
  location: location
}

// Create Host Pool (Pooled)
resource avdhpooled 'Microsoft.DesktopVirtualization/hostPools@2021-03-09-preview' = {
  name: avdfirstpool
  tags: resourceTags
  location: location
  properties: {
    hostPoolType: 'Pooled' 
    loadBalancerType: 'BreadthFirst'
    preferredAppGroupType:  'Desktop'
  }
  dependsOn: [
    avdwks
  ]
}

// Create Host Pool (Personal)
resource avdpersonal 'Microsoft.DesktopVirtualization/hostPools@2021-03-09-preview' = {
  name: avdsecondpool
  tags: resourceTags
  location: location
  properties: {
    hostPoolType: 'Personal' 
    loadBalancerType: 'Persistent'
    preferredAppGroupType:  'Desktop'
  }
  dependsOn: [
    avdwks
  ]
}
