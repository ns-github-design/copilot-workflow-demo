variable "resource_group_name" {
    type        = string
    description = "The name of the resource group"
}
variable "location" {
    type        = string
    description = "The Azure region where the resource group will be created"
}
variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}
variable "address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}
variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}
variable "subnet_address_prefixes" {
  description = "Address prefixes for the subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}
variable "nsg_name" {
  description = "Name of the Network Security Group"
  type        = string
}
variable "route_table_name" {
  description = "Name of the Route Table"
  type        = string
}
variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
variable "key_vault_name" {
  description = "Name of the Azure Key Vault"
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
