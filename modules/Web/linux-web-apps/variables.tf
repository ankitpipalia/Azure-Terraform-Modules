variable "linux_web_app_name" {
  description = "The name of the Linux Web App"
  type        = string
}

variable "location" {
  description = "The location"
  type        = string
}

variable "resource_group" {
  description = "The resource group name"
  type        = string
}

variable "https_only" {
  description = "Whether to only allow HTTPS traffic"
  type        = bool
  default = true
}

variable "enabled" {
  description = "Whether to enable the web app"
  type        = bool
  default     = true
}

variable "service_plan_id" {
  description = "The ID of the App Service Plan"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to resources (inclusive)"
  type        = object({
    environment         = string
    project        = string
  })
}

variable "custom_tags" {
  description = "Custom tags to be applied to resources (in addition to the tags above)"
  type        = map(string)
  default     = {}
}

variable "app_settings" {
  description = "The app settings"
  type        = map(string)
}

variable "client_affinity_enabled" {
  description = "Whether client affinity is enabled"
  type        = bool
}

variable "identity_ids" {
  description = "The list of user-assigned identity IDs"
  type        = list(string)
}

variable "site_config" {
  description = "The site configuration"
  type        = object({
    always_on                                     = bool
    container_registry_managed_identity_client_id = string
    container_registry_use_managed_identity       = bool
    ftps_state                                    = string
    http2_enabled                                 = bool
    use_32_bit_worker                             = bool
    websockets_enabled                            = bool
    worker_count                                  = number
    ip_restriction                                = list(object({
      name                      = string
      ip_address                = string
      service_tag               = string
      virtual_network_subnet_id = string
      priority                  = number
      action                    = string
      headers                   = map(object({
        x_azure_fdid      = string
        x_fd_health_probe = string
        x_forwarded_for   = string
        x_forwarded_host  = string
      }))
    }))
    scm_ip_restriction                            = list(object({
      name                      = string
      ip_address                = string
      service_tag               = string
      virtual_network_subnet_id = string
      priority                  = number
      action                    = string
      headers                   = map(object({
        x_azure_fdid      = string
        x_fd_health_probe = string
        x_forwarded_for   = string
        x_forwarded_host  = string
      }))
    }))
    application_stack                             = object({
      docker_image        = string
      docker_image_tag    = string
      dotnet_version      = string
      java_server         = string
      java_server_version = string
      java_version        = string
      php_version         = string
      python_version      = string
      node_version        = string
      ruby_version        = string
    })
  })
}

variable "logs" {
  description = "The logs configuration"
  type        = object({
    detailed_error_messages = bool
    failed_request_tracing  = bool
    http_logs               = object({
      file_system = object({
        retention_in_days = number
        retention_in_mb   = number
      })
    })
  })
}

variable "storage_account" {
  description = "The storage account"
  type        = list(object({
    access_key   = string
    account_name = string
    name         = string
    share_name   = string
    type         = string
    mount_path   = string
  }))
}

variable "application_stack" {
  description = "The application stack"
  type        = object({
    docker_image        = string
    docker_image_tag    = string
    dotnet_version      = string
    java_server         = string
    java_server_version = string
    java_version        = string
    php_version         = string
    python_version      = string
    node_version        = string
    ruby_version        = string
  })
  default = {
    docker_image        = null
    docker_image_tag    = null
    dotnet_version      = null
    java_server         = null
    java_server_version = null
    java_version        = null
    php_version         = null
    python_version      = null
    node_version        = null
    ruby_version        = null
  }
}