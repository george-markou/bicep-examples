param resourceTags object = {
  
}
param adminUsername string = 'ausername'
param adminPassword string = 'somethingmemorable'
param computerName string = 'bicepwinvm'

resource vm1 'Microsoft.Compute/virtualMachines@2021-04-01' = {
  name: computerName
  location: resourceGroup().name
  tags: resourceTags
  properties: {
    evictionPolicy: 'Deallocate'
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
    hardwareProfile: {
      vmSize: 'Standard_B2ms'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: string()
          properties: {
            primary: true
          }
        }
      ]
    }
    osProfile: {
      adminPassword: adminPassword
      adminUsername: adminUsername
      computerName: computerName
    }
  }
}

