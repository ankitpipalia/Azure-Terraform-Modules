locals {
  dbname_list = [for n in azurerm_mssql_database.this : n.name]
  secret_map = { for name in local.dbname_list : "mssql-${lower(name)}-database-url" => {
    value = "jdbc:sqlserver://${var.server_fqdn}:1433;database=${name}"
  } }
}

output "mssql_database_secrets" {
  value       = local.secret_map
  description = "Map of Database Name to JDBC Connection String"
}

output "sql_server_id" {
  value       = { for k, v in azurerm_mssql_database.this : k => v.server_id }
  description = "Id of SQL server"
}

output "sql_database_names" {
  value       = { for k, v in azurerm_mssql_database.this : k => v.name }
  description = "Database name of the Azure SQL Database created."
}

output "sql_database_max_size" {
  value       = { for k, v in azurerm_mssql_database.this : k => v.max_size_gb }
  description = "Database max size in GB of the Azure SQL Database created."
}

output "storage_account_type" {
  value       = { for k, v in azurerm_mssql_database.this : k => v.storage_account_type }
  description = "Storage Account Type"
}