output "storage_account_id" {
  description = "The ID of the storage account"
  value       = azurerm_storage_account.sa.id
}

output "storage_account_primary_access_key" {
  description = "The primary access key for the storage account"
  value       = azurerm_storage_account.sa.primary_access_key
  sensitive   = true
}

output "storage_account_secondary_access_key" {
  description = "The secondary access key for the storage account"
  value       = azurerm_storage_account.sa.secondary_access_key
  sensitive   = true
}

output "storage_account_primary_blob_endpoint" {
  description = "The endpoint URL for blob storage in the primary location"
  value       = azurerm_storage_account.sa.primary_blob_endpoint
}

output "storage_account_primary_blob_host" {
  description = "The hostname with port for blob storage in the primary location"
  value       = azurerm_storage_account.sa.primary_blob_host
}

output "storage_account_primary_dfs_endpoint" {
  description = "The endpoint URL for dfs storage in the primary location"
  value       = azurerm_storage_account.sa.primary_dfs_endpoint
}

output "storage_account_primary_dfs_host" {
  description = "The hostname with port for dfs storage in the primary location"
  value       = azurerm_storage_account.sa.primary_dfs_host
}

output "storage_account_primary_file_endpoint" {
  description = "The endpoint URL for file storage in the primary location"
  value       = azurerm_storage_account.sa.primary_file_endpoint
}

output "storage_account_primary_file_host" {
  description = "The hostname with port for file storage in the primary location"
  value       = azurerm_storage_account.sa.primary_file_host
}

output "storage_account_primary_web_endpoint" {
  description = "The endpoint URL for web storage in the primary location"
  value       = azurerm_storage_account.sa.primary_web_endpoint
}

output "storage_account_primary_web_host" {
  description = "The hostname with port for web storage in the primary location"
  value       = azurerm_storage_account.sa.primary_web_host
}

output "storage_account_primary_queue_endpoint" {
  description = "The endpoint URL for queue storage in the primary location"
  value       = azurerm_storage_account.sa.primary_queue_endpoint
}

output "storage_account_primary_queue_host" {
  description = "The hostname with port for queue storage in the primary location"
  value       = azurerm_storage_account.sa.primary_queue_host
}

output "storage_account_primary_table_endpoint" {
  description = "The endpoint URL for table storage in the primary location"
  value       = azurerm_storage_account.sa.primary_table_endpoint
}

output "storage_account_primary_table_host" {
  description = "The hostname with port for table storage in the primary location"
  value       = azurerm_storage_account.sa.primary_table_host
}

output "storage_encryption_scope_ids" {
  description = "The IDs of the storage encryption scopes"
  value = [for scope in azurerm_storage_encryption_scope.scope : scope.id]
}

output "storage_container_ids" {
  description = "The IDs of the storage containers"
  value = [for container in azurerm_storage_container.container : container.id]
}