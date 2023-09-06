resource "azurerm_linux_web_app" "Web_App" {
    
    name = var.web_app_name
    resource_group_name = var.resource_group_name
    location = var.location
    service_plan_id = var.app_service_plan_id
    app_settings = var.app_settings
    https_only = var.enable_https
    tags = var.tags


dynamic "site_config" {
    for_each = var.site_config

    content {
      always_on                   = lookup(site_config.value, "always_on", false)
      app_command_line            = lookup(site_config.value, "app_command_line", null)
      default_documents           = lookup(site_config.value, "default_documents", null)
      dotnet_framework_version    = lookup(site_config.value, "dotnet_framework_version", "v2.0")
      ftps_state                  = lookup(site_config.value, "ftps_state", "FtpsOnly")
      health_check_path           = lookup(site_config.value, "health_check_path", null)
      number_of_workers           = var.service_plan.per_site_scaling == true ? lookup(site_config.value, "number_of_workers") : null
      http2_enabled               = lookup(site_config.value, "http2_enabled", false)
      ip_restriction              = concat(local.subnets, local.ip_address, local.service_tags)
      scm_use_main_ip_restriction = var.scm_ips_allowed != [] || var.scm_subnet_ids_allowed != null ? false : true
      scm_ip_restriction          = concat(local.scm_subnets, local.scm_ip_address, local.service_tags)
      java_container              = lookup(site_config.value, "java_container", null)
      java_container_version      = lookup(site_config.value, "java_container_version", null)
      java_version                = lookup(site_config.value, "java_version", null)
      local_mysql_enabled         = lookup(site_config.value, "local_mysql_enabled", null)
      linux_fx_version            = lookup(site_config.value, "linux_fx_version", null)
      windows_fx_version          = lookup(site_config.value, "windows_fx_version", null)
      managed_pipeline_mode       = lookup(site_config.value, "managed_pipeline_mode", "Integrated")
      min_tls_version             = lookup(site_config.value, "min_tls_version", "1.2")
      php_version                 = lookup(site_config.value, "php_version", null)
      python_version              = lookup(site_config.value, "python_version", null)
      remote_debugging_enabled    = lookup(site_config.value, "remote_debugging_enabled", null)
      remote_debugging_version    = lookup(site_config.value, "remote_debugging_version", null)
      scm_type                    = lookup(site_config.value, "scm_type", null)
      use_32_bit_worker_process   = lookup(site_config.value, "use_32_bit_worker_process", true)
      websockets_enabled          = lookup(site_config.value, "websockets_enabled", null)


      dynamic "cors" {
        for_each = lookup(site_config.value, "cors", [])
        content {
          allowed_origins     = cors.value.allowed_origins
          support_credentials = lookup(cors.value, "support_credentials", null)
        }
      }
    }
  }

#   auth_settings {
#     enabled                        = var.enable_auth_settings
#     default_provider               = var.default_auth_provider
#     allowed_external_redirect_urls = []
#     issuer                         = format("https://sts.windows.net/%s/", data.azurerm_client_config.main.tenant_id)
#     unauthenticated_client_action  = var.unauthenticated_client_action
#     token_store_enabled            = var.token_store_enabled

#     dynamic "active_directory" {
#       for_each = var.active_directory_auth_setttings
#       content {
#         client_id         = lookup(active_directory_auth_setttings.value, "client_id", null)
#         client_secret     = lookup(active_directory_auth_setttings.value, "client_secret", null)
#         allowed_audiences = concat(formatlist("https://%s", [format("%s.azurewebsites.net", var.app_service_name)]), [])
#       }
#     }
#   }

#   dynamic "backup" {
#     for_each = var.enable_backup ? [{}] : []
#     content {
#       name                = coalesce(var.backup_settings.name, "DefaultBackup")
#       enabled             = var.backup_settings.enabled
#       storage_account_url = format("https://${data.azurerm_storage_account.storeacc.0.name}.blob.core.windows.net/${azurerm_storage_container.storcont.0.name}%s", data.azurerm_storage_account_blob_container_sas.main.0.sas)
#       schedule {
#         frequency_interval       = var.backup_settings.frequency_interval
#         frequency_unit           = var.backup_settings.frequency_unit
#         retention_period_in_days = var.backup_settings.retention_period_in_days
#         start_time               = var.backup_settings.start_time
#       }
#     }
#   }

  dynamic "connection_string" {
    for_each = var.connection_strings
    content {
      name  = lookup(connection_string.value, "name", null)
      type  = lookup(connection_string.value, "type", null)
      value = lookup(connection_string.value, "value", null)
    }
  }

  identity {
    type         = var.identity_ids != null ? "SystemAssigned, UserAssigned" : "SystemAssigned"
    identity_ids = var.identity_ids
  }

#   dynamic "storage_account" {
#     for_each = var.storage_mounts
#     content {
#       name         = lookup(storage_account.value, "name")
#       type         = lookup(storage_account.value, "type", "AzureFiles")
#       account_name = lookup(storage_account.value, "account_name", null)
#       share_name   = lookup(storage_account.value, "share_name", null)
#       access_key   = lookup(storage_account.value, "access_key", null)
#       mount_path   = lookup(storage_account.value, "mount_path", null)
#     }
#   }

  lifecycle {
    ignore_changes = [
      tags,
      site_config,
      backup,
      auth_settings,
      storage_account,
      identity,
      connection_string,
    ]
  }
}

