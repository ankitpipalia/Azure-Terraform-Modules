## Usage

# MySQL Server example:

```hcl
module "mysql_server" {
  source = "./modules/Databases/mysql-server"

  mysql_server_name      = "ankitsimformserver"
  resource_group_name    = module.resource_group.name
  location               = module.resource_group.location
  administrator_login    = "mysqladmin"
  administrator_password = "P@ssw0rd1234"
  mysql_version          = "5.7"
  backup_retention_days        = 7
  create_mode                  = "Default"
  geo_redundant_backup_enabled = false
  sku_name                     = "B_Standard_B1s"
  zone                         = "1"

  tags       = local.tags
  extra_tags = local.extra_tags
}
```

## Inputs

| Name                            | Description                                                                                                                                                              | Type                    | Default        | Required |
| ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------- | -------------- | :------: |
| `keyvault_name`                | The name of the Keyvault where the DB credentials are stored.                                                                                                           | `string`                | `null`         |   Yes    |
| `resource_group_name`          | The name of the Resource Group where the MySQL Flexible Server should exist.                                                                                            | `string`                |                |   Yes    |
| `location`                     | The Azure Region where the MySQL Flexible Server should exist.                                                                                                            | `string`                |                |   Yes    |
| `mysql_server_name`            | The name which should be used for this MySQL Flexible Server.                                                                                                             | `string`                |                |   Yes    |
| `administrator_login`          | The Administrator login for the MySQL Flexible Server. Required when `create_mode` is Default.                                                                          | `string`                |                |   Yes    |
| `administrator_password`       | The Password associated with the `administrator_login` for the MySQL Flexible Server. Required when `create_mode` is Default.                                           | `string` (sensitive)    |                |   Yes    |
| `store_db_password_in_keyvault` | Should the DB password be stored in Keyvault? Defaults to `false`.                                                                                                        | `bool`                 | `false`        |    No    |
| `key_vault_id`                | The ID of the Keyvault where the DB credentials are stored.                                                                                                              | `string`                | `null`         |    No    |
| `backup_retention_days`        | The backup retention days for the MySQL Flexible Server. Possible values are between 1 and 35 days. Defaults to 7.                                                       | `number`                | `7`            |    No    |
| `create_mode`                  | The creation mode which can be used to restore or replicate existing servers. Possible values are Default, PointInTimeRestore, GeoRestore, and Replica.                 | `string`                | `Default`      |    No    |
| `geo_redundant_backup_enabled` | Should geo redundant backup be enabled? Defaults to `false`.                                                                                                              | `bool`                 | `false`        |    No    |
| `sku_name`                     | `sku_name` should start with SKU tier B (Burstable), GP (General Purpose), MO (Memory Optimized) like B_Standard_B1s.                                                    | `string`                |                |   Yes    |
| `mysql_version`                | The version of the MySQL Flexible Server to use. Possible values are 5.7, and 8.0.21.                                                                                    | `string`                | `8.0.21`       |    No    |
| `zone`                         | Specifies the Availability Zone in which this MySQL Flexible Server should be located. Possible values are 1, 2, and 3.                                                    | `string`                | `1`            |    No    |
| `tags`                         | Tags to be applied to resources (inclusive).                                                                                                                               | `object({ environment = string, project = string })` |                |    No    |
| `extra_tags`                   | Extra tags to be applied to resources (in addition to the tags above).                                                                                                    | `map(string)`           | `{}`           |    No    |
