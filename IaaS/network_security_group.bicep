param networkSecurityGroupName string = 'name'
param networkSecurityGroupLocation string = 'location'

resource nsg 'Microsoft.Network/networkSecurityGroups@2021-02-01' = {
  name: 'nsg-${networkSecurityGroupName}'
  location: networkSecurityGroupLocation
  properties: {
  }
}
