output "id" {
  value       = azurerm_mssql_server.mssql_server.id
  description = "Id of Azure SQL Server"
}

output "name" {
  value       = azurerm_mssql_server.mssql_server.name
  description = "Azure SQL Server Name"
}

output "fqdn" {
  value       = azurerm_mssql_server.mssql_server.fully_qualified_domain_name
  description = "Fully Qualified Domain Name of Azure SQL Server"
}

output "identity" {
  value       = azurerm_mssql_server.mssql_server.identity
  description = "Identity properties assigned to Azure SQL Server"
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