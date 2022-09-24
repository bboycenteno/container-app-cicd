param location string
param app string
param env string
param logAnalyticsId string = '363b65a0-8a0b-4ad8-9900-76ff591123f4'
param logAnalyticsKey string = 'VNzGxcu6uc/V0WqWAMxhlNPtsykliPJ2J9cHYaOxYQwBUMgegEEtwoLitJ9Kls2dmvHsGTRRp2TkFi9yrpAYRw=='

param vnetName string = 'juniorjRG-vnet'
param infraSubnetName string = 'infraSubnet'
param runtimeSubnetName string = 'runtimeSubnet'

resource CAEnv 'Microsoft.App/managedEnvironments@2022-03-01' = {
  name: 'managed-env-${app}-${env}'
  location: location
  properties: {
    appLogsConfiguration: {      
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: logAnalyticsId
        sharedKey: logAnalyticsKey
      }
    }
    vnetConfiguration: {
      internal: true
      infrastructureSubnetId: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, infraSubnetName)
      platformReservedCidr: '10.1.0.0/16'
      platformReservedDnsIP: '10.1.0.2'
      dockerBridgeCidr: '10.2.0.0/16'
      runtimeSubnetId: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, runtimeSubnetName)
    }
    zoneRedundant: false
  }
}

output containerEnvironmentId string = CAEnv.id
