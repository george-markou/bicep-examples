param routeTableName string = 'lz-corp-001'
param routeTableLocation string = 'westeurope'

resource routetable 'Microsoft.Network/routeTables@2021-02-01' = {
  name: 'rt-${routeTableName}'
  location: routeTableLocation
  properties: {
  }
}
