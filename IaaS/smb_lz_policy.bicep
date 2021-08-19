param policyAssignmentName01 string
param policyAssignmentName02 string
param policyAssignmentName03 string
param policyAssignmentName04 string
param policyAssignmentName05 string
param policyDefinitionID01 string
param policyDefinitionID02 string
param policyDefinitionID03 string
param policyDefinitionID04 string
param policyDefinitionID05 string

resource policyAssignment01 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
    name: policyAssignmentName01
    properties: {
        policyDefinitionId: policyDefinitionID01
    }
}

resource policyAssignment01 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: policyAssignmentName01
  properties: {
      policyDefinitionId: policyDefinitionID01
  }
}

resource policyAssignment02 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: policyAssignmentName02
  properties: {
      policyDefinitionId: policyDefinitionID02
  }
}

resource policyAssignment03 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: policyAssignmentName03
  properties: {
      policyDefinitionId: policyDefinitionID03
  }
}

resource policyAssignment04 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: policyAssignmentName04
  properties: {
      policyDefinitionId: policyDefinitionID04
  }
}

resource policyAssignment05 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: policyAssignmentName05
  properties: {
      policyDefinitionId: policyDefinitionID05
  }
}

resource avd 'Microsoft.DesktopVirtualization/workspaces@2021-05-13-preview' = {
  name: 
  
}
