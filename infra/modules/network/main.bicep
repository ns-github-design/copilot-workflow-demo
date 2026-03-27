targetScope = 'resourceGroup'

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
param tags object = {}

resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: vnetName
  location: resourceGroup().location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: addressSpace
    }
  }
}

resource nsg 'Microsoft.Network/networkSecurityGroups@2024-05-01' = {
  name: nsgName
  location: resourceGroup().location
  tags: tags
}

resource allowHttp 'Microsoft.Network/networkSecurityGroups/securityRules@2024-05-01' = {
  name: 'AllowHTTP'
  parent: nsg
  properties: {
    priority: 100
    direction: 'Inbound'
    access: 'Allow'
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '80'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
  }
}

resource routeTable 'Microsoft.Network/routeTables@2024-05-01' = {
  name: routeTableName
  location: resourceGroup().location
  tags: tags
}

resource defaultRoute 'Microsoft.Network/routeTables/routes@2024-05-01' = {
  name: 'DefaultRoute'
  parent: routeTable
  properties: {
    addressPrefix: '0.0.0.0/0'
    nextHopType: 'Internet'
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  name: subnetName
  parent: vnet
  properties: {
    addressPrefixes: subnetAddressPrefixes
    networkSecurityGroup: {
      id: nsg.id
    }
    routeTable: {
      id: routeTable.id
    }
  }
}

output virtualNetworkId string = vnet.id
output virtualNetworkName string = vnet.name
output virtualNetworkAddressSpace array = vnet.properties.addressSpace.addressPrefixes
output subnetId string = subnet.id
output subnetName string = subnet.name
output networkSecurityGroupId string = nsg.id
output networkSecurityGroupName string = nsg.name
output routeTableId string = routeTable.id
output routeTableName string = routeTable.name
