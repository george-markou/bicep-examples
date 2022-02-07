param staticwebsiteName string = 'avdurlredirect2'
param repoUrl string = 'https://github.com/george-markou/azstaticwebsite'
param branch string = 'main'
@secure()
param repoToken string = ''

@description('Deploy Azure Static Website')
resource staticwebsite 'Microsoft.Web/staticSites@2021-02-01' = {
  name: staticwebsiteName
  sku: {
    name: 'Free'
  }
  location: resourceGroup().location
  properties: {
    repositoryUrl:repoUrl
    branch: branch
    repositoryToken: repoToken
  }
}
