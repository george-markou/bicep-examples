targetScope  = 'subscription'

param policyAssignmentName string = 'Append Owner tag and its value to resource groups'
param policyDefinitionID string = '/providers/Microsoft.Authorization/policyDefinitions/49c88fc8-6fd1-46fd-a676-f12d1d3a4c71'
param tagName string = 'Owner'
param tagValue string = 'Not-Defined'

resource policyAssignment 'Microsoft.Authorization/policyAssignments@2020-09-01' = {
    name: policyAssignmentName
    properties: {
        policyDefinitionId: policyDefinitionID
        enforcementMode: 'Default'
        displayName: policyAssignmentName
        parameters: {
          tagName: {
            value: tagName
          }
          tagValue: {
            value: tagValue
          }
        }
        description: 'Appends a Custom Tag and its value to resource groups'
    }
}
