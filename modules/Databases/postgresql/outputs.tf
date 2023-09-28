output "host" {
  description = "The FQDN of the deployed database"
  value       = azurerm_postgresql_server.db.fqdn
}

output "port" {
  description = "The port to use when connecting to the database"
  value       = 5432
}

output "name" {
  description = "The name of the default database created"
  value       = azurerm_postgresql_database.db.name
}

output "id" {
  description = "The ID of the deployed database"
  value       = azurerm_postgresql_server.db.id
}

output "username" {
  description = "The username to use when connecting to the database as the admin"
  value       = "${azurerm_postgresql_server.db.administrator_login}@${azurerm_postgresql_server.db.name}"
}

output "password" {
  description = "The password to use when connecting to the database as the admin"
  value       = azurerm_postgresql_server.db.administrator_login_password
  sensitive   = true
}