module "resource_group" {
  source = "../modules/resource-group"

  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

module "network" {
  source = "../modules/network"

  resource_group_name     = module.resource_group.resource_group_name
  location                = module.resource_group.resource_group_location
  vnet_name               = var.vnet_name
  subnet_name             = var.subnet_name
  subnet_address_prefixes = var.subnet_address_prefixes
  nsg_name                = var.nsg_name
  route_table_name        = var.route_table_name
  tags                    = var.tags
}

module "key_vault" {
  source = "../modules/key-vault"

  key_vault_name       = var.key_vault_name
  location             = module.resource_group.resource_group_location
  resource_group_name  = module.resource_group.resource_group_name
  sku_name             = var.sku_name
  purge_protection_enabled = var.purge_protection_enabled
  soft_delete_retention_days = var.soft_delete_retention_days
  tags                 = var.tags
}

module "storage_account" {
  source = "../modules/storage-account"

  storage_account_name = var.storage_account_name
  resource_group_name  = module.resource_group.resource_group_name
  location             = module.resource_group.resource_group_location
  tags                 = var.tags
}