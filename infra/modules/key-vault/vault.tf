data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "this" {
  name                       = var.key_vault_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id = data.azurerm_client_config.current.tenant_id
  sku_name                   = var.sku_name
  public_network_access_enabled = false
  purge_protection_enabled   = var.purge_protection_enabled
  soft_delete_retention_days = var.soft_delete_retention_days

  tags = var.tags
}