resource "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_kind             = var.account_kind
  account_tier             = var.account_tier
  account_replication_type = var.replication_type
  enable_https_traffic_only         = var.enable_https_traffic_only
  min_tls_version                   = var.min_tls_version


  tags = merge(
    {
      "Environment" = var.tags.environment,
      "Project"     = var.tags.project
    },
    var.custom_tags
  )

  identity {
    type = "SystemAssigned"
  }

  dynamic "blob_properties" {
    for_each = ((var.account_kind == "BlockBlobStorage" || var.account_kind == "StorageV2") ? [1] : [])
    content {
      versioning_enabled = var.blob_versioning_enabled

      dynamic "delete_retention_policy" {
        for_each = (var.blob_delete_retention_days == 0 ? [] : [1])
        content {
          days = var.blob_delete_retention_days
        }
      }
      
      dynamic "container_delete_retention_policy" {
        for_each = (var.container_delete_retention_days == 0 ? [] : [1])
        content {
          days = var.container_delete_retention_days
        }
      }
      
      dynamic "cors_rule" {
        for_each = (var.blob_cors == null ? {} : var.blob_cors)
        content {
          allowed_headers    = cors_rule.value.allowed_headers
          allowed_methods    = cors_rule.value.allowed_methods
          allowed_origins    = cors_rule.value.allowed_origins
          exposed_headers    = cors_rule.value.exposed_headers
          max_age_in_seconds = cors_rule.value.max_age_in_seconds
        }
      }
    }
  }

  dynamic "static_website" {
    for_each = (var.static_website_enabled == true ? [1] : [])
    content {
      index_document     = var.index_path
      error_404_document = var.custom_404_path
    }
  }

  network_rules {
    default_action             = var.default_network_rule
    ip_rules                   = values(var.access_list)
    virtual_network_subnet_ids = values(var.service_endpoints)
    bypass                     = var.traffic_bypass
  }
}
## azure reference https://docs.microsoft.com/en-us/azure/storage/common/infrastructure-encryption-enable?tabs=portal
resource "azurerm_storage_encryption_scope" "scope" {
  for_each = var.encryption_scopes

  name                               = each.key
  storage_account_id                 = azurerm_storage_account.sa.id
  source                             = coalesce(each.value.source, "Microsoft.Storage")
  infrastructure_encryption_required = coalesce(each.value.enable_infrastructure_encryption, var.infrastructure_encryption_enabled)
}

resource "azurerm_storage_container" "container" {
  for_each = try({ for c in var.containers : c.name => c }, {})

  storage_account_name = azurerm_storage_account.sa.name

  name                  = each.key
  container_access_type = each.value.container_access_type
  metadata              = each.value.metadata
}