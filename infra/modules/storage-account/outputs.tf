output "storage_account_id" {
    value       = azurerm_storage_account.storage.id
    description = "The ID of the storage account"
}

output "primary_blob_endpoint" {
    value       = azurerm_storage_account.storage.primary_blob_endpoint
    description = "The primary blob endpoint"
}