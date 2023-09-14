## Usage

# MSSQL Database example:

```hcl
module "mssql_server" {
  source = "~/git/Azure-Terraform-Modules/modules/Databases/mssql-server"
  mssql_server_name = "test-mssql-server-xyz"

  resource_group_name = module.resource_group.name
  location            = module.resource_group.location

  administrator_login          = "mssqladmin"
  administrator_login_password = "H@Sh1CoR3!"

  tags                  = local.tags
  extra_tags            = local.extra_tags

  azure_ad_admin_login    = "xyz@outlook.com"
  azure_ad_admin_object_id = "xxxx-xxxx-xxxx-xxxx-xxxx"

}
```

## Inputs

| Name                              | Description                                                                                         | Type     | Default   | Required |
|-----------------------------------|-----------------------------------------------------------------------------------------------------|----------|-----------|:--------:|
| `administrator_login`             | The administrator login name for the server                                                         | string   | -         | yes      |
| `administrator_login_password`    | The password associated with the `administrator_login`                                                | string   | -         | yes      |
| `azure_ad_admin_login`            | The login username of the Azure AD Administrator of this SQL Server                                   | string   | -         | yes      |
| `azure_ad_admin_object_id`        | The object id of the Azure AD Administrator of this SQL Server                                        | string   | -         | yes      |
| `connection_policy`               | The connection policy the server will use: [Default|Proxy|Redirect]                                    | string   | "Default" | no       |
| `custom_mssql_server_name`        | The name of the Microsoft SQL Server (optional)                                                       | string   | null      | no       |
| `firewall_rule_name`              | The name of the firewall rule (optional)                                                              | string   | null      | no       |
| `ip_rules`                        | Map of IP addresses permitted for access to DB                                                        | map(string) | {}      | no       |
| `key_vault_id`                   | Key Vault ID (optional)                                                                              | string   | null      | no       |
| `key_vault_key_id`               | Key Vault Key id for transparent data encryption of server (optional)                                  | string   | null      | no       |
| `location`                        | Specifies the supported Azure location where the resource exists                                       | string   | -         | yes      |
| `mssql_defender_state`            | Manages Microsoft Defender state on the MSSQL server (optional)                                        | string   | null      | no       |
| `mssql_server_name`               | The name of the Microsoft SQL Server                                                                 | string   | -         | yes      |
| `public_network_access_enabled`    | Whether public network access is allowed for this server                                              | bool     | false     | no       |
| `resource_group_name`             | The name of the resource group in which to create the Microsoft SQL Server                              | string   | -         | yes      |
| `server_version`                  | Server version                                                                                        | string   | "12.0"    | no       |
| `tags`                            | Tags to be applied to resources (inclusive)                                                            | object   | -         | yes      |
|                                    | - `environment`: Environment tag                                                                      | string   | -         | yes      |
|                                    | - `project`: Project tag                                                                              | string   | -         | yes      |
| `tde_encryption_enabled`          | Boolean flag that enables Transparent Data Encryption of the server                                    | bool     | false     | no       |
| `tde_key_permissions`             | List of TDE key permissions                                                                           | list(string) | ["Get", "WrapKey", "UnwrapKey", "GetRotationPolicy", "SetRotationPolicy"] | no |
| `auto_rotation_enabled`           | Server will continuously check the Key Vault for any new versions of the key (optional)             | bool     | true      | no       |
| `minimum_tls_version`             | The Minimum TLS Version for all SQL Database and SQL Data Warehouse databases associated with the server: [1.0|1.1|1.2] | string | "1.2" | no |
