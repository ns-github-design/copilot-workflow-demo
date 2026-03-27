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
