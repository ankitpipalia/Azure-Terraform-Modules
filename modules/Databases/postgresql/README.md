# terraform-azurerm-postgresql-server

A Terraform module for deploying a simple PostgreSQL instance.

## Usage

Before deploying this module you will need to have a vNet deployed with a subnet that has `Microsoft.Sql` enabled as a `service_endpoint`.  Without this other servers you deploy into this subnet will _not_ be able to access the instance securely. You can use the following module to deploy a vNet with a subnet that has this enabled:

```hcl
module "subnets" {
  source = "./modules/Networking/subnets"

  for_each              = toset(local.subnets)
  subnet_name           = each.value
  resource_group_name   = module.resource_group.name
  virtual_network_name  = module.virtual_network.name
  subnet_address_prefix = cidrsubnet(module.virtual_network.address_space[0], 8, index(local.subnets, each.value)) # Ensure unique address for each subnet
  service_endpoints = "Microsoft.Sql"
}
```



```hcl
module "pg_db" {
  source = "./modules/Databases/postgresql"

  location             = module.resource_group.location
  resource_group_name  = module.resource_group.name

  postgresql_server_name = "tesadasdst-pg"
  sku                    = "GP_Gen5_2" # Changed SKU to support vnet access
  subnet_id = module.subnets["subnet1"].id
  postgresql_database_name     = "testxyabzcpg-db"
  administrator_login          = "pgsqladmin"
  administrator_login_password = "P@ssw0rd1234"

  tags                = local.tags
  extra_tags          = local.extra_tags
}
```

## Resources

| Name | Type |
|------|------|
| [azurerm_postgresql_database.db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_database) | resource |
| [azurerm_postgresql_firewall_rule.custom_rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_firewall_rule) | resource |
| [azurerm_postgresql_server.db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_server) | resource |
| [azurerm_postgresql_virtual_network_rule.vnet_access](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_virtual_network_rule) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name                              | Description                                                                                                         | Type     | Default  | Required |
|-----------------------------------|---------------------------------------------------------------------------------------------------------------------|----------|----------|----------|
| `postgresql_server_name`          | The name of the Azure PostgreSQL Server.                                                                           | string   |          | Yes      |
| `location`                        | The Azure region where the PostgreSQL Server will be created.                                                     | string   |          | Yes      |
| `resource_group_name`             | The name of the Azure Resource Group where the PostgreSQL Server and related resources will be deployed.         | string   |          | Yes      |
| `administrator_login`             | The administrator login for the PostgreSQL Server.                                                                 | string   |          | Yes      |
| `administrator_login_password`    | The password for the PostgreSQL Server administrator login.                                                        | string   |          | Yes      |
| `sku`                             | The SKU (pricing tier) for the PostgreSQL Server.                                                                  | string   |          | Yes      |
| `postgresql_version`              | The version of PostgreSQL to use.                                                                                  | string   |          | Yes      |
| `max_allocated_storage_mb`        | The maximum storage capacity for the PostgreSQL Server in megabytes.                                              | number   |          | Yes      |
| `backup_retention_days`           | The number of days to retain backups for the PostgreSQL Server.                                                     | number   |          | Yes      |
| `auto_grow_enabled`               | Enable or disable auto-grow for the PostgreSQL Server storage.                                                      | bool     |          | Yes      |
| `publicly_accessible`             | Enable or disable public network access to the PostgreSQL Server.                                                   | bool     |          | Yes      |
| `tags`                            | A map of tags to apply to the PostgreSQL Server and related resources.                                              | map      | {}       | No       |
| `extra_tags`                      | Additional tags to apply to the PostgreSQL Server and related resources.                                             | map      | {}       | No       |
| `postgresql_database_name`        | The name of the PostgreSQL database to create.                                                                     | string   |          | Yes      |
| `subnet_id`                       | The ID of the subnet where the PostgreSQL Server should be placed for virtual network access.                    | string   |          | No       |
| `additional_ip_allowlist`         | A list of additional IP addresses allowed to access the PostgreSQL Server (firewall rules).                        | list(string) | []    | No       |


## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_host"></a> [host](#output\_host) | The FQDN of the deployed database |
| <a name="output_db_name"></a> [name](#output\_name) | The name of the default database created |
| <a name="output_db_id"></a> [id](#output\_id) | The ID of the deployed database |
| <a name="output_db_password"></a> [password](#output\_password) | The password to use when connecting to the database as the admin |
| <a name="output_db_port"></a> [port](#output\_port) | The port to use when connecting to the database |
| <a name="output_db_username"></a> [username](#output\_username) | The username to use when connecting to the database as the admin |