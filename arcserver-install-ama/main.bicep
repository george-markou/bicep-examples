resource ama 'Microsoft.HybridCompute/machines/extensions@2021-06-10-preview' = {
  name: '/AzureMonitorWindowsAgent'
  location: resourceGroup().location
  properties: {
    publisher: 'Microsoft.Azure.Monitor'
    type: 'AzureMonitorWindowsAgent'
    autoUpgradeMinorVersion: true
  }
}
