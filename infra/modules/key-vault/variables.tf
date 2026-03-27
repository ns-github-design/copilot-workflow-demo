variable "key_vault_name" {
  description = "Name of the Azure Key Vault"
  type        = string
}

variable "location" {
  description = "Azure region where the Key Vault will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group where the Key Vault will be created"
  type        = string
}

variable "sku_name" {
  description = "SKU for the Key Vault"
  type        = string
  default     = "standard"
}

variable "purge_protection_enabled" {
  description = "Enable purge protection for the Key Vault"
  type        = bool
  default     = false
}

variable "soft_delete_retention_days" {
  description = "Soft delete retention period in days"
  type        = number
  default     = 7
}

variable "tags" {
  description = "Tags to apply to the Key Vault"
  type        = map(string)
  default     = {}
}