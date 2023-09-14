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