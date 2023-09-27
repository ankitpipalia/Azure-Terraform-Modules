output "cosmosdb_id" {
  description = "The CosmosDB Account ID."
  value       = azurerm_cosmosdb_account.cosmo_account.id
}

output "cosmosdb_endpoint" {
  description = "The endpoint used to connect to the CosmosDB account."
  value       = azurerm_cosmosdb_account.cosmo_account.endpoint
}



output "cosmosdb_read_endpoints" {
  description = "A list of read endpoints available for this CosmosDB account."
  value       = azurerm_cosmosdb_account.cosmo_account.read_endpoints
}

output "cosmosdb_write_endpoints" {
  description = "A list of write endpoints available for this CosmosDB account."
  value       = azurerm_cosmosdb_account.cosmo_account.write_endpoints
}

output "cosmosdb_primary_key" {
  description = "The Primary key for the CosmosDB Account."
  value       = azurerm_cosmosdb_account.cosmo_account.primary_master_key
}


output "cosmosdb_primary_readonly_key" {
  description = "The Primary read-only Key for the CosmosDB Account."
  value       = azurerm_cosmosdb_account.cosmo_account.primary_readonly_master_key
}


output "cosmosdb_connection_strings" {
  description = "A list of connection strings available for this CosmosDB account."
  value       = azurerm_cosmosdb_account.cosmo_account.connection_strings
}

