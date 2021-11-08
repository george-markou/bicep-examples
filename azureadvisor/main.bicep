@description('Specify Custom Advisor properties')
param actiongroup1 string = '/subscriptions/xxxxxxxxxxxxx/resourceGroups/some-rg/providers/microsoft.insights/actionGroups/itadmin'
param digestName string = 'WeeklyDigest'
param digestFrequency int = 7 

@description('Configure Azure Advisor')
resource advisor 'Microsoft.Advisor/configurations@2020-01-01' = {
  name: 'default'
  properties: {
    digests: [
      {
        actionGroupResourceId: actiongroup1
        categories: [
          'HighAvailability'
          'Performance'
          'Cost'
          'Security'         
        ]
        frequency: digestFrequency
        name: digestName
        state: 'Active'
      }
    ]
  }
}
