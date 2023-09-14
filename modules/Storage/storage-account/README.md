# Azure Storage Account Module

This module creates an Azure Storage Account with a set of containers and optional encryption scopes.

## Usage

```hcl
module "storage_account" {
  source = ".~/git/Azure-Terraform-Modules/modules/storage_account"

  storage_account_name = "mystorageaccount"
  resource_group_name  = "myresourcegroup"
  location             = "West Europe"
  account_kind         = "StorageV2"
  account_tier         = "Standard"
  replication_type     = "LRS"
  enable_https_traffic_only = true
  min_tls_version      = "TLS1_2"

  tags = {
    environment = "dev"
    project     = "myproject"
  }

  extra_tags = {
    owner = "me"
  }

  blob_versioning_enabled = true
  blob_delete_retention_days = 7
  container_delete_retention_days = 7

  blob_cors = {
    allowed_headers    = ["*"]
    allowed_methods    = ["GET", "POST"]
    allowed_origins    = ["*"]
    exposed_headers    = ["*"]
    max_age_in_seconds = 3600
  }

  static_website_enabled = true
  index_path             = "index.html"
  custom_404_path        = "404.html"

  default_network_rule   = "Deny"
  access_list            = ["1.2.3.4/32"]
  service_endpoints      = ["/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup/providers/Microsoft.Network/virtualNetworks/myvnet/subnets/mysubnet"]
  traffic_bypass         = ["Logging", "Metrics"]

  encryption_scopes = {
    "myscope" = {
      source = "Microsoft.KeyVault"
      enable_infrastructure_encryption = true
    }
  }

  containers = [
    {
      name = "mycontainer"
      container_access_type = "private"
      metadata = {
        owner = "me"
      }
    }
  ]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|  
| storage\_account\_name | The name of the storage account | string | n/a | yes |
| resource\_group\_name | The name of the resource group | string | n/a | yes |
| location | The Azure location | string | n/a | yes |  
| account\_kind | The type of storage account | string | n/a | yes |
| account\_tier | The tier of storage account | string | n/a | yes |
| replication\_type | The replication type of storage account | string | n/a | yes |
| enable\_https\_traffic\_only | Enable https traffic only | bool | true | no |
| min\_tls\_version | The minimum TLS version to allow | string | TLS1\_2 | no |
| tags | A map of tags to assign to the resource | map | {} | no |
| blob\_properties | Properties for BlobStorage accounts | object | {} | no | 
| static\_website\_enabled | Enable static website hosting | bool | false | no |
| index\_path | The webpage index document path for static sites | string | index.html | no |  
| custom\_404\_path | The custom 404 page for static sites | string | 404.html | no |
| default\_network\_rule | Default network access rule | string | Allow | no |
| access\_list | List of IP addresses to allow access | map(string) | {} | no |
| service\_endpoints | Service endpoint objects | object | {} | no |
| traffic\_bypass | Traffic bypass options | list(string) | [] | no |
| encryption\_scopes | Encryption scopes to create | map(object) | {} | no |
| containers | Storage containers to create | list(object) | [] | no |

## Outputs

| Name | Description |
|------|-------------|
| storage_account_id | The ID of the storage account |
| storage_account_primary_access_key | The primary access key for the storage account |
| storage_account_secondary_access_key | The secondary access key for the storage account |
| storage_account_primary_blob_endpoint | The endpoint URL for blob storage in the primary location |
| storage_account_primary_blob_host | The hostname with port for blob storage in the primary location |
| storage_account_primary_dfs_endpoint | The endpoint URL for dfs storage in the primary location |
| storage_account_primary_dfs_host | The hostname with port for dfs storage in the primary location |
| storage_account_primary_file_endpoint | The endpoint URL for file storage in the primary location |
| storage_account_primary_file_host | The hostname with port for file storage in the primary location |
| storage_account_primary_web_endpoint | The endpoint URL for web storage in the primary location |
| storage_account_primary_web_host | The hostname with port for web storage in the primary location |
| storage_account_primary_queue_endpoint | The endpoint URL for queue storage in the primary location |
| storage_account_primary_queue_host | The hostname with port for queue storage in the primary location |
| storage_account_primary_table_endpoint | The endpoint URL for table storage in the primary location |
| storage_account_primary_table_host | The hostname with port for table storage in the primary location |
| storage_encryption_scope_ids | The IDs of the storage encryption scopes |
| storage_container_ids | The IDs of the storage containers |