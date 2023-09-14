output "sql_server_id" {
  value       = azurerm_mssql_database.mssql_database.server_id
  description = "Id of SQL server"
}

output "sql_database_names" {
  value       = azurerm_mssql_database.mssql_database.name
  description = "Database name of the Azure SQL Database created."
}

output "sql_database_max_size" {
  value       = azurerm_mssql_database.mssql_database.max_size_gb
  description = "Database max size in GB of the Azure SQL Database created."
}

output "storage_account_type" {
  value       = azurerm_mssql_database.mssql_database.storage_account_type
  description = "Storage Account Type"
}