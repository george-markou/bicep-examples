param vmName string
param location string

param resourceTags object = {
  Application: 'Not-Defined'
  CostCenter: 'Not-Defined'
  Environment: 'Production'
  Owner: 'Markou.me'
}

param vmSize string
param vmAdminName string
param subnetId string 
param vmNicName string = '${vmName}-nic'

resource vm'Microsoft.Compute/virtualMachines@2021-03-01' = {
  name: vmName
  location: location
  tags: resourceTags
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-Datacenter'
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: '${vmName}_OsDisk_1'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        writeAcceleratorEnabled: false
        managedDisk: {
          storageAccountType: 'Premium_LRS'
          id: '${vmName}_OsDisk_1'
        }
        diskSizeGB: 127
      }
    }
    osProfile: {
      computerName: vmName
      adminUsername: vmAdminName
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
          assessmentMode: 'ImageDefault'
        }
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: vmNicName
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
    licenseType: 'Windows_Server'
  }
  dependsOn: [
    vmNic
  ]
}

resource vmNic 'Microsoft.Network/networkInterfaces@2021-02-01' = {
  name: vmNicName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAddress: ''
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: subnetId
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: [
        
      ]
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
  }
}
