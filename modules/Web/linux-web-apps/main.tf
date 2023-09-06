resource "azurerm_linux_web_app" "Web_App" {

  name = var.web_app_name

  resource_group_name = var.resource_group_name

  location = var.location

  service_plan_id = var.app_service_plan_id

  app_settings = var.app_settings

  https_only = var.enable_https

  tags = var.tags

  # Deploy Code From Terraform
  zip_deploy_file = var.zip_deploy_file_path

  dynamic "site_config" {
    for_each = var.site_config

    content {
      #   Common Settings For Application Stack
      #  (Optional) If this Linux Web App is Always On enabled. Defaults to true.
      always_on = lookup(site_config.value, "always_on", false)


      # Optional) Should the HTTP2 be enabled?
      http2_enabled = lookup(site_config.value, "http2_enabled", false)

      # (Optional) One or more ip_restriction blocks as defined above.
      ip_restriction = concat(local.subnets, local.ip_address, local.service_tags)

      scm_use_main_ip_restriction = var.scm_ips_allowed != [] || var.scm_subnet_ids_allowed != null ? false : true
      scm_ip_restriction          = concat(local.scm_subnets, local.scm_ip_address, local.service_tags)

      # Application Stack Specific Settings
      app_command_line         = lookup(site_config.value, "app_command_line", null)
      default_documents        = lookup(site_config.value, "default_documents", null)
      ftps_state               = lookup(site_config.value, "ftps_state", "FtpsOnly")
      health_check_path        = lookup(site_config.value, "health_check_path", null)
      number_of_workers        = var.service_plan.per_site_scaling == true ? lookup(site_config.value, "number_of_workers") : null
      java_container         = lookup(site_config.value, "java_container", null)
      java_container_version = lookup(site_config.value, "java_container_version", null)
      java_version           = lookup(site_config.value, "java_version", null)
      local_mysql_enabled    = lookup(site_config.value, "local_mysql_enabled", null)
      dotnet_framework_version = lookup(site_config.value, "dotnet_framework_version", "v2.0")
      php_version               = lookup(site_config.value, "php_version", null)
      python_version            = lookup(site_config.value, "python_version", null)
      remote_debugging_enabled  = lookup(site_config.value, "remote_debugging_enabled", null)
      websockets_enabled        = lookup(site_config.value, "websockets_enabled", null)
      remote_debugging_version  = lookup(site_config.value, "remote_debugging_version", null)
      scm_type                  = lookup(site_config.value, "scm_type", null)
      use_32_bit_worker_process = lookup(site_config.value, "use_32_bit_worker_process", true)
      linux_fx_version   = lookup(site_config.value, "linux_fx_version", null)
      windows_fx_version = lookup(site_config.value, "windows_fx_version", null)

      # (Optional) The Site load balancing. Possible values include: WeightedRoundRobin, LeastRequests, LeastResponseTime,
      # WeightedTotalTraffic, RequestHash, PerSiteRoundRobin. Defaults to LeastRequests if omitted.
      load_balancing_mode = lookup(site_config.values, "load_balancing_mode")

      # (Optional) Managed pipeline mode. Possible values include Integrated, and Classic.
      managed_pipeline_mode = lookup(site_config.value, "managed_pipeline_mode", "Integrated")

      # This configures the minimum version of TLS required for SSL requests. Possible values include: 1.0, 1.1, and 1.2. Defaults to 1.2.
      min_tls_version = lookup(site_config.value, "min_tls_version", "1.2")




      # Define Cors Settings 
      dynamic "cors" {
        for_each = lookup(site_config.value, "cors", [])
        content {
          allowed_origins     = cors.value.allowed_origins
          support_credentials = lookup(cors.value, "support_credentials", null)
        }
      }
    }
  }

  # Define Connection Strings
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

