targetScope = 'subscription'

param resourceGroupName string
param location string
param tags object = {}
param vnetName string
param addressSpace array = [
  '10.0.0.0/16'
]
param subnetName string
param subnetAddressPrefixes array = [
  '10.0.1.0/24'
]
param nsgName string
param routeTableName string
param keyVaultName string
param tenantId string = subscription().tenantId
param skuName string = 'standard'
param purgeProtectionEnabled bool = true
param softDeleteRetentionDays int = 7
param storageAccountName string

module resourceGroupModule '../modules/resource-group/main.bicep' = {
  params: {
    resourceGroupName: resourceGroupName
    location: location
    tags: tags
  }
}

module networkModule '../modules/network/main.bicep' = {
  scope: resourceGroup(resourceGroupName)
  params: {
    vnetName: vnetName
    addressSpace: addressSpace
    subnetName: subnetName
    subnetAddressPrefixes: subnetAddressPrefixes
    nsgName: nsgName
    routeTableName: routeTableName
    tags: tags
  }
  dependsOn: [
    resourceGroupModule
  ]
}

module keyVaultModule '../modules/key-vault/main.bicep' = {
  scope: resourceGroup(resourceGroupName)
  params: {
    keyVaultName: keyVaultName
    tenantId: tenantId
    skuName: skuName
    purgeProtectionEnabled: purgeProtectionEnabled
    softDeleteRetentionDays: softDeleteRetentionDays
    tags: tags
  }
  dependsOn: [
    resourceGroupModule
  ]
}

module storageModule '../modules/storage-account/main.bicep' = {
  scope: resourceGroup(resourceGroupName)
  params: {
    storageAccountName: storageAccountName
    tags: tags
  }
  dependsOn: [
    resourceGroupModule
  ]
}

output resourceGroupId string = resourceGroupModule.outputs.resourceGroupId
output subnetId string = networkModule.outputs.subnetId
output keyVaultUri string = keyVaultModule.outputs.keyVaultUri
output storageAccountId string = storageModule.outputs.storageAccountId
