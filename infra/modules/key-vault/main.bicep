targetScope = 'resourceGroup'

param keyVaultName string
param tenantId string = subscription().tenantId
param skuName string = 'standard'
param purgeProtectionEnabled bool = false
param softDeleteRetentionDays int = 7
param tags object = {}

resource kv 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: keyVaultName
  location: resourceGroup().location
  tags: tags
  properties: {
    tenantId: tenantId
    sku: {
      family: 'A'
      name: toUpper(skuName)
    }
    publicNetworkAccess: 'Disabled'
    enablePurgeProtection: purgeProtectionEnabled
    enableSoftDelete: true
    softDeleteRetentionInDays: softDeleteRetentionDays
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    accessPolicies: []
  }
}

output keyVaultId string = kv.id
output keyVaultName string = kv.name
output keyVaultUri string = kv.properties.vaultUri
