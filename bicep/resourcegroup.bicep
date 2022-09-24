param resourceGroupName string
param resourceGroupLocation string

targetScope = 'subscription'

resource newRG 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: resourceGroupName
  location: resourceGroupLocation
}
