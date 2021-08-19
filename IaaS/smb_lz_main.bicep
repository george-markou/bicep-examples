targetScope = 'subscription'

//Define Organization parameters
@minLength(3)
@maxLength(11)
param organizationName string = 'neworg'
param location string = 'westeurope'

param resourceGroupPrefrix string = organizationName
param dateTime string = utcNow('d')

param resourceTags object = {
  Application: 'Not-Defined'
  CostCenter: 'Not-Defined'
  CreationTime: dateTime
  Environment: 'Production'
  Owner: 'Markou.me'
}

//Define Hub virtual network deployment parameters
param vnetName string = '${organizationName}-vnet'
param firewallsubnetName string = 'AzureFirewallSubnet'
param gatewaysubnetName string = 'GatewaySubnet'
param bastionsubnetName string = 'AzureBastionSubnet'

param vnetaddressPrefix string ='10.0.0.0/16'
param firewallsubnetPrefix string = '10.0.0.0/26'
param gatewaysubnetPrefix string = '10.0.0.128/26'
param bastionsubnetPrefix string = '10.0.1.0/27'

//Define Diagnostics storage account parameters
param StorageAccountName string = 'sadg${organizationName}01'
param skuName string = 'Standard_LRS'

//Define Recovery services vault parameters
param recoveryServicesVaultName string = '${organizationName}-rsv-01'

//Define Automation account parameters
param automationAccountName string = '${organizationName}-aa-01'

//Define Virtual network gateway parameters
param VPNGWName string = '${organizationName}-vpng'
param vpnType string = 'RouteBased'
param VPNGWpip string = '${VPNGWName}-pip'


//Create Resource Groups
resource rgidp 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name : '${resourceGroupPrefrix}-identity-rg'
  location : 'westeurope'
  tags: resourceTags
}
resource rgsvcs 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name : '${resourceGroupPrefrix}-sharedsvcs-rg'
  location : 'westeurope'
  tags: resourceTags
}
resource rgnetw 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name : '${resourceGroupPrefrix}-vnet-rg'
  location : 'westeurope'
  tags: resourceTags
}
resource rgmig 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name :'${resourceGroupPrefrix}-azmig-rg'
  location : 'westeurope'
  tags: resourceTags
}
resource rgapp 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name :'${resourceGroupPrefrix}-application-rg'
  location : 'westeurope'
  tags: resourceTags
}


//Create Hub Virtual Network
module hubvnet './smb_lz_network.bicep' = {
  name: '${organizationName}-vnet'
  scope: resourceGroup(rgnetw.name)
  params: {
    hubvnetName : vnetName
    location : location
    resourceTags: resourceTags
    vnetaddressPrefix : vnetaddressPrefix
    hubsubnetName1 : firewallsubnetName
    hubsubnetName2 : gatewaysubnetName 
    hubsubnetName3 : bastionsubnetName
    hubsubnetPrefix1 : firewallsubnetPrefix
    hubsubnetPrefix2 : gatewaysubnetPrefix
    hubsubnetPrefix3 : bastionsubnetPrefix
  }
}

//Create Diagnostics storage account
module stgdiag './smb_lz_storage_accounts.bicep' = {
  name: StorageAccountName
  scope: resourceGroup(rgsvcs.name)
  params: {
    StorageAccountName: StorageAccountName
    location : location
    resourceTags: resourceTags
    skuName: skuName
  }
}

//Create Recovery Services vault
module rsv './smb_lz_recovery_services_vault.bicep' = {
  name: recoveryServicesVaultName
  scope: resourceGroup(rgsvcs.name)
  params: {
  recoveryServicesVaultName: recoveryServicesVaultName
  location: location
  resourceTags: resourceTags
 }
}

//Create Automation Account
module aaccount './smb_lz_automation_accounts.bicep' = {
  name: automationAccountName
  scope: resourceGroup(rgsvcs.name)
  params: {
  automationAccountName: automationAccountName
  location: location
  resourceTags: resourceTags
 }
}

//Create Virtual network gateway
module vpngw './smb_lz_virtual_network_gateway.bicep' = {
  name: VPNGWName
  scope: resourceGroup(rgnetw.name)
  params: {
  VPNGWName: VPNGWName
  location: location
  gatewaysubnetName: gatewaysubnetName
  vnetName: vnetName
  vpnType: vpnType
  rgnetw: rgnetw.name
  resourceTags: resourceTags
  VPNGWpip: VPNGWpip
 }
}

//Apply Resource Locks
module createRgLock1 './resource_lock_module.bicep' = {
  name: 'CanNotDelete'
  scope: resourceGroup(rgidp.name)
  params: {
    name: 'CanNotDelete'
  }
}
