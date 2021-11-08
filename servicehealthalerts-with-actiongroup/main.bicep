@description('Specify Service Health Alerts custom properties')
param actiongroup1 string = 'itadmins'
param location string = 'global'
param countryCode string = '1'
param phoneNumber string = '6900000000'
param emailReceiversgroup1 string = 'itadminsMAIL'
param emailAddressReceiversgroup1 string = 'itadmins@markou.me'
param smsReceiversgroup1 string = 'itadminsSMS'
param serviceHealthAlertsName string = 'Service Health'

@description('Create Action Group')
resource actiongroup 'microsoft.insights/actionGroups@2019-06-01' = {
  name: actiongroup1
  location: location
  properties: {
    enabled: true
    groupShortName: actiongroup1
    emailReceivers: [
      {
       name: emailReceiversgroup1
       emailAddress: emailAddressReceiversgroup1
       useCommonAlertSchema: true
      }
    ]
    smsReceivers: [
      {
        name: smsReceiversgroup1
        countryCode: countryCode
        phoneNumber: phoneNumber
      }
    ]  
  
  }
}

@description('Create Service Health Alerts')
resource servicehealthalerts 'Microsoft.Insights/activityLogAlerts@2020-10-01' = {
  name: serviceHealthAlertsName
  location: location
  properties: {
    condition: {
      allOf: [
        {
          field: 'category'
          equals: 'ServiceHealth'
        }
        {
          field: 'status'
          equals: 'Active'
        }
      ]
    }
    actions: {
      actionGroups: [
        {
          actionGroupId: actiongroup.id
        }
      ]
        }
        scopes: [
          subscription().id
        ]
    }
  }
