param app string
param env string
param location string = 'eastus'

@secure()
param registryPassword string

targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01'existing = {
  name: 'juniorjRG'
}

module containerEnv 'container-env.bicep' = {
  scope: rg
  name: 'containerEnv'
  params: {
    location: location
    app: app
    env: env
  }
}

module containerApp 'container-app.bicep' = {
  scope: rg
  name: '${app}-container'
  params: {
    location: location
    app: app
    env: env
    containerAppEnvId: containerEnv.outputs.containerEnvironmentId
    containerImage: 'node:alpine'
    registryPassword: registryPassword
  }
  dependsOn: [
    containerEnv
  ] 
}
