# Azure Terraform Module for Azure Storage Account

This module creates an Azure Storage Account and a Storage Container within the account.

## Requirements

- Terraform v0.13+
- Azure Provider v2.40+

## Usage

```hcl
module "storage_account" {
  source  = "app.terraform.io/<ORG_NAME>/storage_account/azurerm"
  version = "1.0.0"

  resource_group_name      = "my-resource-group"
  location                 = "West Europe"
  storage_account_name     = "mystorageaccount"
  account_tier             = "Standard"
  account_replication_type = "GRS"
  tags                     = { Environment = "dev" }
  storage_container_name   = "mycontainer"
  container_access_type    = "private"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | The name of the resource group in which to create the storage account. | `string` | n/a | yes |
| location | The location/region in which to create the storage account. | `string` | `"West Europe"` | no |
| storage_account_name | The name of the storage account. | `string` | n/a | yes |
| account_tier | Defines the Tier to use for this storage account. | `string` | `"Standard"` | no |
| account_replication_type | Defines the type of replication to use for this storage account. | `string` | `"GRS"` | no |
| tags | The tags to associate with your network and resources. | `map(string)` | `{}` | no |
| storage_container_name | The name of the storage container within the storage account. | `string` | n/a | yes |
| container_access_type | Defines the access level used for this storage container. | `string` | `"private"` | no |

## Outputs

| Name | Description |
|------|-------------|
| resource_group_name | The name of the resource group. |
| storage_account_name | The name of the storage account. |
| storage_account_primary_access_key | The primary access key for the storage account. |
| storage_account_secondary_access_key | The secondary access key for the storage account. |
| storage_account_connection_string | The connection string for the storage account. |
| storage_container_name | The name of the storage container. |

## Authors

Module managed by [Your Name](https://github.com/yourgithubusername)

## License

MIT
