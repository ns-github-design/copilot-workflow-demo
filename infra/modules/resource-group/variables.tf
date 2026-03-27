variable "resource_group_name" {
    type        = string
    description = "The name of the resource group"
}

variable "location" {
    type        = string
    description = "The Azure region where the resource group will be created"
}

variable "tags" {
    type        = map(string)
    description = "Tags to apply to the resource group"
    default     = {}
}