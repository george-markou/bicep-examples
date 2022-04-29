param vmName string
param location string = resourceGroup().location
param workspaceId string


@description('Deploy Log Analytics Agent Extension for Windows')
resource ama 'Microsoft.HybridCompute/machines/extensions@2021-06-10-preview' = {
  name: '${vmName}/AzureMonitorWindowsAgent'
  location: location
  properties: {
    publisher: 'Microsoft.Azure.Monitor'
    type: 'AzureMonitorWindowsAgent'
    autoUpgradeMinorVersion: true
    settings: {
      workspaceId: workspaceId
    }
    protectedSettings: {
      workspaceId: workspaceId
    }
  }
}


@description('Deploy OpenSSH Server Extension for Windows')
resource extension 'Microsoft.HybridCompute/machines/extensions@2021-12-10-preview' = {
  name: '${vmName}/WindowsOpenSSH'
  location: location
  properties: {
    publisher: 'Microsoft.Azure.OpenSSH'
    type: 'WindowsOpenSSH'
    autoUpgradeMinorVersion: true
    settings: {}
    protectedSettings: {}
  }
}

