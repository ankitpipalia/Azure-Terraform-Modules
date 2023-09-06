variable "web_app_name" {
  description = "Name of the web app"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where the web app will be deployed"
  type        = string
}

variable "app_service_plan_id" {
  description = "ID of the App Service Plan"
  type        = string
}

variable "app_settings" {
  description = "Map of application settings for the web app"
  type        = map(string)
}

variable "site_config" {
  description = "Site configuration for Application Service"
  type        = any
  default     = {}
}

variable "ips_allowed" {
  description = "IPs restriction for App Service to allow specific IP addresses or ranges"
  type        = list(string)
  default     = []
}

variable "subnet_ids_allowed" {
  description = "Allow Specific Subnets for App Service"
  type        = list(string)
  default     = []
}

variable "subnet_id" {
  description = "The resource id of the subnet for vnet association"
  default     = null
}

variable "service_tags_allowed" {
  description = "Restrict Service Tags for App Service"
  type        = list(string)
  default     = []
}

variable "enable_client_affinity" {
  description = "Should the App Service send session affinity cookies, which route client requests in the same session to the same instance?"
  type        = bool
  default     = false
}

variable "enable_client_certificate" {
  description = "Does the App Service require client certificates for incoming requests"
  type        = bool
  default     = false
}

variable "enable_https" {
  description = "Enable HTTPS for the web app"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "connection_strings" {
  description = "Map of connection strings for the web app"
  type = list(object({
    name  = string
    type  = string
    value = string
  }))
}

variable "identity_ids" {
  description = "List of identity IDs for the web app"
  type        = list(string)
}

variable "zip_deploy_file_path" {
  description = "Zip Deployment File path"
  type        = string
}