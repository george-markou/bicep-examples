// Specify VM custom properties such as name, admin username, admin password, VNET subnet to connect to and preferred tags
param computerName string = 'bicepvm01'
param adminUsername string = 'azadmin'
param adminPassword string = 'somethintoremember'
param netSubnet string = '/subscriptions/cb7a8f90-5950-4993-ab11-7a3ddf5b7741/resourceGroups/neworg-vnet-rg/providers/Microsoft.Network/virtualNetworks/neworg-vnet/subnets/ApplicationSubnet'
param resourceTags object = {
  Application: 'Bicep'
  CostCenter: 'Marketing'
  Environment: 'Production'
  Owner: 'George Markou'
}

// Create VM Public IP Address
resource vm01pip 'Microsoft.Network/publicIPAddresses@2021-02-01' = {
  name: 'pip-${computerName}-01'
  location: resourceGroup().location
  tags: resourceTags
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

// Create VM Network Security Group
resource vm01nsg 'Microsoft.Network/networkSecurityGroups@2021-02-01' = {
  name: 'nsg-${computerName}'
  location: resourceGroup().location
  properties: {
    securityRules: [
      {
        name: 'Allow_RDP'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

// Create VM Network Interface Card
resource vm01nic 'Microsoft.Network/networkInterfaces@2021-02-01' = {
  name: 'nic-${computerName}-01'
  location: resourceGroup().location
  tags: resourceTags
  properties: {
  ipConfigurations: [
  {
    name: 'ipconfig01'
    properties: {
      privateIPAllocationMethod: 'Dynamic'
      subnet: {
        id: netSubnet
      }
    publicIPAddress: {
      id: resourceId(resourceGroup().name, 'Microsoft.Network/publicIPAddresses', vm01pip.name)
    }
    }
  }
  ]
  dnsSettings: {
    dnsServers: [
      
    ]
  }
  enableIPForwarding: false
  networkSecurityGroup: {
    id: vm01nsg.id
    location: resourceGroup().location
  }
  }
  dependsOn: [
    vm01nsg
    vm01pip
  ]  
}

// Create Virtual Machine
resource vm01 'Microsoft.Compute/virtualMachines@2021-03-01' = {
  name: computerName
  location: resourceGroup().location
  tags: resourceTags
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B2ms'
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-datacenter-gensecond'
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: '${computerName}_OsDisk_1'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
        diskSizeGB: 127
      }
      dataDisks: []
    }
    osProfile: {
      computerName: computerName
      adminUsername: adminUsername
      adminPassword: adminPassword
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
          assessmentMode: 'ImageDefault'
          enableHotpatching: false
        }
      }
      secrets: []
      allowExtensionOperations: true
      //requireGuestProvisionSignal: true
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: vm01nic.id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
  dependsOn: [
    vm01nic
  ]
}

