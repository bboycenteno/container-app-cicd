param location string
param app string
param env string
param containerAppEnvId string
param containerImage string
param registryPassword string

resource container 'Microsoft.App/containerApps@2022-01-01-preview' = {
  name: app
  location: location
  tags: {
    app: app
    env: env
  }
  properties: {
    configuration: {
      activeRevisionsMode: 'Single'
      ingress: {
        allowInsecure: true
        external: false
        targetPort: 80
        transport: 'auto'
      }
      registries: [
         {
          passwordSecretRef: 'container-password'
          server: 'juniorj.azurecr.io'
          username: 'juniorj'
         }
      ]
      secrets: [
        {
          name: 'container-password'
          value: registryPassword
        }
      ]
    }

    managedEnvironmentId: containerAppEnvId
    template: {
      containers: [
        {
          image: 'juniorj.azurecr.io/samples/${containerImage}'
          name: 'nginx'          
        }
      ]

      scale: {
        maxReplicas: 3
        minReplicas: 1
      }
    }
  }
}
