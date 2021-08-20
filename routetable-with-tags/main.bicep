// Specify Route Table custom properties such as the name, location and preferred tags
param routeTableName string = 'myroutetable'
param routeTableLocation string = 'westeurope'
param resourceTags object = {
  Application: 'Bicep'
  CostCenter: 'Marketing'
  Environment: 'Production'
  Owner: 'George Markou'
}

// Create Route Table with a default Route to route all traffic to an NVA
resource routeTable 'Microsoft.Network/routeTables@2021-02-01' = {
  name: routeTableName
  location: routeTableLocation
  tags: resourceTags
  properties: {
    disableBgpRoutePropagation: false // OR True
    routes: [
      {
        id: '1'
        name: 'TO-NVA'
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopIpAddress: '10.0.0.4'
          nextHopType: 'VirtualAppliance'
        }
      }
    ]
  }
}
