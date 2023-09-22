output "id" {
  value       = azurerm_mysql_flexible_server.mysql.id
  description = "Id of Azure SQL Server"
}

output "name" {
  value       = azurerm_mysql_flexible_server.mysql.name
  description = "Azure SQL Server Name"
}

output "location" {
  description = "The location/region where the MySQL Server is created."
  value       = azurerm_mysql_flexible_server.mysql.location
}

output "mysql_database_name" {
  description = "The name of the MySQL Database."
  value       = azurerm_mysql_flexible_database.database.name
}

output "admin_login" {
  description = "The Administrator Login for the MySQL Server."
  value       = azurerm_mysql_flexible_server.mysql.administrator_login
}

output "version" {
  description = "The version of MySQL used."
  value       = azurerm_mysql_flexible_server.mysql.version
}