

resource "azurerm_storage_account" "storage_account" {

    name = var.storage_account_name
    resource_group_name = var.resource_group_name
    location = var.location
    access_tier = var.access_tier
    account_kind = var.account_kind
    account_replication_type = var.account_replication_type
    cross_tenant_replication_enabled = var.cross_tenant_replication_enabled
    enable_https_traffic_only = var.enable_https_traffic_only
    min_tls_version = var.min_tls_version
    shared_access_key_enabled = var.shared_access_key_enabled
    public_network_access_enabled = var.public_network_access_enabled
    default_to_oauth_authentication = var.default_to_oauth_authentication
    is_hns_enabled = var.is_hns_enabled
    
    identity {
      
    }

    tags = var.tags


    blob_properties {
      
    }

  
}