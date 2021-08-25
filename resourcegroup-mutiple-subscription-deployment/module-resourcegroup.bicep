targetScope = 'subscription'

param resourceGroupName string
param location string

// Create Resource Groups
resource createRG 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}
