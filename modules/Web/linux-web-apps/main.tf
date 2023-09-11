resource "azurerm_linux_web_app" "lwa" {
  name                    = var.linux_web_app_name
  location                = var.location
  resource_group_name     = var.resource_group
  service_plan_id         = var.service_plan_id
  https_only              = var.https_only
  enabled                 = var.enabled

  tags = merge(
    {
      "Environment" = var.tags.environment,
      "Project"     = var.tags.project
    },
    var.custom_tags
  )

  app_settings            = var.app_settings
  client_affinity_enabled = var.client_affinity_enabled

  identity {
    type         = var.identity_ids == null ? "SystemAssigned" : "SystemAssigned, UserAssigned"
    identity_ids = var.identity_ids
  }

  site_config {
    always_on                                     = var.site_config.always_on
    container_registry_managed_identity_client_id = var.site_config.container_registry_managed_identity_client_id
    container_registry_use_managed_identity       = var.site_config.container_registry_use_managed_identity
    ftps_state                                    = var.site_config.ftps_state
    http2_enabled                                 = var.site_config.http2_enabled
    use_32_bit_worker                             = var.site_config.use_32_bit_worker
    websockets_enabled                            = var.site_config.websockets_enabled
    worker_count                                  = var.site_config.worker_count

    dynamic "ip_restriction" {
      for_each = var.ip_restriction
      content {
        name                      = ip_restriction.value.name
        ip_address                = ip_restriction.value.ip_address
        service_tag               = ip_restriction.value.service_tag
        virtual_network_subnet_id = ip_restriction.value.virtual_network_subnet_id
        priority                  = ip_restriction.value.priority
        action                    = ip_restriction.value.action
        dynamic "headers" {
          for_each = ip_restriction.value.headers
          content {
            x_azure_fdid      = headers.value.x_azure_fdid
            x_fd_health_probe = headers.value.x_fd_health_probe
            x_forwarded_for   = headers.value.x_forwarded_for
            x_forwarded_host  = headers.value.x_forwarded_host
          }
        }
      }
    }

    dynamic "scm_ip_restriction" {
      for_each = var.scm_ip_restriction
      content {
        name                      = scm_ip_restriction.value.name
        ip_address                = scm_ip_restriction.value.ip_address
        service_tag               = scm_ip_restriction.value.service_tag
        virtual_network_subnet_id = scm_ip_restriction.value.virtual_network_subnet_id
        priority                  = scm_ip_restriction.value.priority
        action                    = scm_ip_restriction.value.action
        dynamic "headers" {
          for_each = scm_ip_restriction.value.headers
          content {
            x_azure_fdid      = headers.value.x_azure_fdid
            x_fd_health_probe = headers.value.x_fd_health_probe
            x_forwarded_for   = headers.value.x_forwarded_for
            x_forwarded_host  = headers.value.x_forwarded_host
          }
        }
      }
    }

    application_stack {
      docker_image        = var.application_stack["docker_image"]
      docker_image_tag    = var.application_stack["docker_image_tag"]
      dotnet_version      = var.application_stack["dotnet_version"]
      java_server         = var.application_stack["java_server"]
      java_server_version = var.application_stack["java_server_version"]
      java_version        = var.application_stack["java_version"]
      php_version         = var.application_stack["php_version"]
      python_version      = var.application_stack["python_version"]
      node_version        = var.application_stack["node_version"]
      ruby_version        = var.application_stack["ruby_version"]
    }
  }

  
  logs {
    detailed_error_messages = var.logs.detailed_error_messages
    failed_request_tracing  = var.logs.failed_request_tracing
    http_logs {
      file_system {
        retention_in_days = var.logs.http_logs.file_system.retention_in_days
        retention_in_mb   = var.logs.http_logs.file_system.retention_in_mb
      }
    }
  }
  dynamic "storage_account" {
    for_each = var.storage_account
    content {
      access_key   = storage_account.value.access_key
      account_name = storage_account.value.account_name
      name         = storage_account.value.name
      share_name   = storage_account.value.share_name
      type         = storage_account.value.type
      mount_path   = storage_account.value.mount_path
    }
  }
}