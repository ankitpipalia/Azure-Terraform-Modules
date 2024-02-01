output "name" {
  description = "The name of the Cosmos DB PostgreSQL cluster"
  value       = azurerm_cosmosdb_postgresql_cluster.postgres.name
}

output "node_count" {
  description = "The number of nodes in the Cosmos DB PostgreSQL cluster"
  value       = azurerm_cosmosdb_postgresql_cluster.postgres.node_count
}

output "postgres_cluster_name" {
  description = "The name of the PostgreSQL cluster within Cosmos DB"
  value       = azurerm_cosmosdb_postgresql_coordinator_configuration.pgsql.name
}

output "value" {
  description = "The value associated with the PostgreSQL coordinator configuration"
  value       = azurerm_cosmosdb_postgresql_coordinator_configuration.pgsql.value
}

output "firewall_rules" {
  description = "The firewall rules associated with the PostgreSQL cluster"
  value       = azurerm_cosmosdb_postgresql_firewall_rule.example
}

output "postgres_node_name" {
  description = "The name of the PostgreSQL node configuration"
  value       = azurerm_cosmosdb_postgresql_node_configuration.pgsql1.name
}

output "postgres_coordination_name" {
  description = "The name of the PostgreSQL coordinator configuration"
  value       = azurerm_cosmosdb_postgresql_coordinator_configuration.pgsql.name
}

output "postgres_role_name" {
  description = "The name of the PostgreSQL role"
  value       = azurerm_cosmosdb_postgresql_role.role_name.name
}

output "password" {
  description = "The password associated with the PostgreSQL role"
  value       = azurerm_cosmosdb_postgresql_role.role_name.password
}
