## Usage

# MSSQL Database example:

```hcl
module "mssql_database" {
  source = "./modules/Databases/mssql-database"
  mssql_database_name = "test-mssql-database-xyz"
  collation = "SQL_Latin1_General_CP1_CI_AS"
  
  
  server_id           = module.mssql_server.id
  storage_account_type = "ZRS"

  databases = {
    testdb1 = {
      name = "testdb1"
      collation = "SQL_Latin1_General_CP1_CI_AS"
    }
  }

  sku = "GP_S_Gen5_2"
  max_size = "20"
  min_capacity = "0.5"

  tags       = local.tags
  extra_tags = local.extra_tags
}
```

## Inputs

| Name                            | Description                                                                                       | Type     | Default                           | Required |
|---------------------------------|---------------------------------------------------------------------------------------------------|----------|-----------------------------------|:--------:|
| `autopause_delay`               | Time in minutes after which the database is automatically paused. A value of -1 disables automatic pause. | number | -1                                | no       |
| `category_list_metrics`         | Category list metrics for Log Analytics.                                                        | list(any) | ["Basic", "WorkloadManagement"] | no       |
| `collation`                     | Specifies the collation of the database.                                                        | string   | "SQL_Latin1_General_CP1_CI_AS"   | no       |
| `create_mode`                   | Type of create mode selected in the database config object.                                       | string   | "Default"                        | no       |
| `creation_source_database_id`   | This variable is used when `create_mode` is set to 'Copy'.                                         | string   | null                             | no       |
| `databases`                     | Map of databases.                                                                                 | map(map(string)) | {}                     | no       |
| `destination_type`              | Log analytics destination type.                                                                   | string   | "Dedicated"                      | no       |
| `log_analytics_workspace_id`    | Log Analytics Workspace ID.                                                                       | string   | ""                                | no       |
| `log_category_list`             | Category list log for Log Analytics.                                                              | list(any) | ["QueryStoreRuntimeStatistics", "QueryStoreWaitStatistics", "Errors", "DatabaseWaitStatistics", "Timeouts", "Blocks", "Deadlocks"] | no |
| `log_retention_days`            | Retention log policy days.                                                                        | number   | 7                                 | no       |
| `mssql_database_name`           | Name of MSSQL database.                                                                           | string   | -                                 | yes      |
| `max_size`                      | The maximum size of the database in gigabytes.                                                    | string   | -                                 | yes      |
| `metric_retention_days`         | Retention metric policy days.                                                                    | number   | 7                                 | no       |
| `min_capacity`                  | The minimum size of the database in gigabytes.                                                    | string   | -                                 | yes      |
| `public_network_access_enabled`  | Whether public network access is allowed for this database.                                        | bool     | false                             | no       |
| `retention_days`                | Specifies the number of days to keep in the Threat Detection audit logs.                           | number   | 3                                 | no       |
| `server_id`                     | ID of SQL server.                                                                                 | string   | -                                 | yes      |
| `sku`                           | Specifies the SKU of the database.                                                                | string   | -                                 | yes      |
| `storage_account_type`          | Specifies the storage account type used to store backups for this database.                        | string   | -                                 | yes      |
| `tags`                          | Tags to be applied to resources (inclusive).                                                       | object   | -                                 | yes      |
|                                 | - `environment`: Environment tag                                                                  | string   | -                                 | yes      |
|                                 | - `project`: Project tag                                                                          | string   | -                                 | yes      |
