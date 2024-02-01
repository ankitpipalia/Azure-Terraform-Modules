

# CosmosDB-Postgresql

A brief description of what this project does and who it's for.

# Terraform Azure Cosmos DB for PostgreSQL Cluster

A Terraform module for deploying and managing an Azure Cosmos DB for PostgreSQL.

## Module Usage

To use this module, include the following code in your Terraform configuration:

```hcl
module "cosmosdb_postgresql"
{
  source                         = "path/to/module/cosmosdb_postgresql"
  postgres_name                  = "my-postgres-db"
  resource_group_name            = "my-resource-group"
  location                       = "East US"
  administrator_login_password   = "f#2190!#"
  node_count                     = 3
  tags = {
    environment = "production"
    project     = "my_project"
  }

  firewall_rules = {
    rule1 = {
      start_ip_address = "10.0.0.1"
      end_ip_address   = "10.0.0.10"
    }
  }
}

```

## Resources

This module deploys the following Azure resources:

- [azurerm_cosmosdb_postgresql_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_postgresql_cluster)
- [azurerm_cosmosdb_postgresql_coordinator_configuration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_postgresql_coordinator_configuration)
- [azurerm_cosmosdb_postgresql_firewall_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_postgresql_firewall_rule)
- [azurerm_cosmosdb_postgresql_node_configuration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_postgresql_node_configuration)
- [azurerm_cosmosdb_postgresql_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_postgresql_role)

## Inputs

| Variable Name                      | Description                                                                                                          | Type       | Default         | Required |
|------------------------------------|----------------------------------------------------------------------------------------------------------------------|------------|-----------------|----------|
| `postgres_name`                    | The name which should be used for this Azure Cosmos DB for PostgreSQL Cluster.                                      | string     |                 | Yes      |
| `resource_group_name`              | The name of the Resource Group where the Azure Cosmos DB for PostgreSQL Cluster will be deployed.                   | string     |                 | Yes      |
| `location`                         | The Azure Region where the Azure Cosmos DB for PostgreSQL Cluster will be deployed.                                | string     |                 | Yes      |
| `administrator_login_password`     | The password of the administrator login.                                                                             | string     |                 | Yes      |
| `coordinator_public_ip_access_enabled` | Coordinate when public IP access is enabled.                                                                    | bool       | `true`          | No       |
| `coordinator_storage_quota_in_mb`  | The coordinator storage allowed for the Azure Cosmos DB for PostgreSQL Cluster.                                    | number     | `null`          | No       |
| `coordinator_vcore_count`          | The coordinator vCore count for the Azure Cosmos DB for PostgreSQL Cluster.                                         | number     | `null`          | No       |
| `node_count`                       | The worker node count of the Azure Cosmos DB for PostgreSQL Cluster. Must be between 0 and 20 (excluding 1).       | number     |                 | Yes      |
| `citus_version`                    | The Citus extension version on the Azure Cosmos DB for PostgreSQL Cluster.                                          | string     | `null`          | No       |
| `coordinator_server_edition`       | The edition of the coordinator server.                                                                              | string     | `GeneralPurpose`| No       |
| `ha_enabled`                       | Value to enable or disable High Availability for the Azure Cosmos DB for PostgreSQL Cluster.                       | bool       | `false`         | No       |
| `node_public_ip_access_enabled`    | Node public IP access is enabled.                                                                                    | bool       | `false`         | No       |
| `node_server_edition`              | The edition of the node server.                                                                                     | string     | `MemoryOptimized`| No       |
| `node_storage_quota_in_mb`         | The storage quota in MB on each worker node.                                                                        | number     | `null`          | No       |
| `point_in_time_in_utc`             | The date and time in UTC (ISO8601 format) for the Azure Cosmos DB for PostgreSQL cluster restore.                 | string     | `null`          | No       |
| `preferred_primary_zone`           | The preferred primary availability zone for the Azure Cosmos DB for PostgreSQL cluster.                             | string     | `null`          | No       |
| `shards_on_coordinator_enabled`    | Is shards on coordinator enabled for the Azure Cosmos DB for PostgreSQL cluster.                                    | bool       | `null`          | No       |
| `source_location`                  | The Azure region of the source Azure Cosmos DB for PostgreSQL cluster for read replica clusters.                    | string     | `null`          | No       |
| `source_resource_id`               | The resource ID of the source Azure Cosmos DB for PostgreSQL cluster for read replica clusters.                     | string     | `null`          | No       |
| `sql_version`                      | The major PostgreSQL version on the Azure Cosmos DB for PostgreSQL cluster.                                          | number     | `null`          | No       |
| `tags`                             | Tags to be applied to resources (inclusive).                                                                       | object     |             | No       |
| `extra_tags`                       | Extra tags to be applied to resources (in addition to the tags above).                                               | map        |            | No       |
| `maintenance_window`               | It defines the day, hour, and minute in a week for maintenance windows.                                              | map(number)| `null`          | No       |
| `postgres_coordination_name`        | The name of the Coordinator Configuration on Azure Cosmos DB for PostgreSQL Cluster.                                 | string     |                 | Yes      |
| `value`                            | The value of the Coordinator Configuration on Azure Cosmos DB for PostgreSQL Cluster.                                | string     |                 | Yes      |
| `firewall_rules`                   | Set firewall rules for the Azure Cosmos DB for PostgreSQL Cluster.                                                     | map(object)|            | No       |
| `postgres_node_name`               | The name of the PostgreSQL node.                                                                                     | string     |                 | Yes      |
| `postgres_role_name`               | The name which should be used for this Azure Cosmos DB for PostgreSQL Role.                                           | string     |                 | Yes      |
| `password`                         | The password of the Azure Cosmos DB for PostgreSQL Role.                                                             | string     |                 | Yes      | |


# Outputs

| Name                         | Description                                               |
|------------------------------|-----------------------------------------------------------|
| `name`                       | The name of the Cosmos DB PostgreSQL cluster.              |
| `node_count`                 | The number of nodes in the Cosmos DB PostgreSQL cluster.   |
| `postgres_cluster_name`      | The name of the PostgreSQL cluster within Cosmos DB.       |
| `value`                      | The value associated with the PostgreSQL coordinator configuration. |
| `firewall_rules`             | The firewall rules associated with the PostgreSQL cluster. |
| `postgres_node_name`         | The name of the PostgreSQL node configuration.             |
| `postgres_coordination_name` | The name of the PostgreSQL coordinator configuration.     |
| `postgres_role_name`         | The name of the PostgreSQL role.                           |
| `password`                   | The password associated with the PostgreSQL role.          |
