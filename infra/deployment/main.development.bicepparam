using 'main.bicep'

param resourceGroupName = 'rg-ghcp-demo-dev'
param location = 'eastus'
param tags = {
  workload: 'copilot-demo'
  environment: 'development'
  owner: 'platform-team'
  costCenter: 'demo'
}
param vnetName = 'vnet-copilot-dev'
param subnetName = 'subnet-default'
param subnetAddressPrefixes = [
  '10.0.1.0/24'
]
param nsgName = 'nsg-copilot-dev'
param routeTableName = 'rt-copilot-dev'
param keyVaultName = 'kvghcpdev003'
param tenantId = '2f03a96e-e5a4-421a-a3a1-965e62d578ad'
param storageAccountName = 'stghcpdev003'
