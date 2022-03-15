param location string = resourceGroup().location

resource ama 'Microsoft.HybridCompute/machines/extensions@2021-06-10-preview' = {
  name: '/AzureMonitorWindowsAgent'
  location: location
  properties: {
    publisher: 'Microsoft.Azure.Monitor'
    type: 'AzureMonitorWindowsAgent'
    autoUpgradeMinorVersion: true
  }
}
