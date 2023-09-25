variable "resource_group_name" {
  description = "The name of the Azure resource group."
  type        = string
}

variable "registry_name" {
  description = "The name of the Azure Container Registry."
  type        = string
}

variable "location" {
  description = "The location/region where the Azure Container Registry will be created."
  type        = string
}

variable "sku" {
  description = "The SKU (pricing tier) of the Azure Container Registry."
  type        = string
  default     = "Standard"
}

variable "admin_enabled" {
  description = "Specifies whether admin user is enabled for the Azure Container Registry."
  type        = optioanl(bool)
  default     = false
}

variable "allow_public_access" {
  description = "Specifies whether public network access is allowed for the Azure Container Registry."
  type        = optional(bool)
  default     = true
}

variable "zone_redundancy_enabled" {
  description = "Specifies whether zone redundancy is enabled for the Azure Container Registry."
  type        = optional(bool)
  default     = false
}

variable "allow_anonymous_pull_enabled" {
  description = "Specifies whether anonymous pull is allowed for the Azure Container Registry."
  type        = optional(bool)
  default     = false
}

variable "network_rule_bypass_option" {
  description = "The bypass option for network rules of the Azure Container Registry."
  type        = optional(string)
  default     = "AzureServices"
}


variable "tags" {
  description = "Tags to be applied to resources (inclusive)"
  type = object({
    environment = string
    project     = string
  })
}

variable "extra_tags" {
  description = "extra tags to be applied to resources (in addition to the tags above)"
  type        = map(string)
  default     = {}
}

variable "identity_ids" {
  description = "Specifies a list of user managed identity ids to be assigned. This is required when `type` is set to `UserAssigned` or `SystemAssigned, UserAssigned`"
  default     = null
}

variable "georeplications" {
  description = "A list of georeplication configurations for the Azure Container Registry."
  type = list(object({
    location                  = string
    regional_endpoint_enabled = bool
    zone_redundancy_enabled   = bool
    tags                      = map(string)
  }))
  default = []
}

variable "encryption" {
  description = "Encrypt registry using a customer-managed key"
  type = object({
    key_vault_key_id   = string
    identity_client_id = string
  })
  default = null
}


variable "network_rule_set" {
  description = "Manage network rules for Azure Container Registries"
  type = object({
    default_action = optional(string)
    ip_rule = optional(list(object({
      ip_range = string
    })))
    virtual_network = optional(list(object({
      subnet_id = string
    })))
  })
  default = null
}

variable "retention_policy" {
  description = "Set a retention policy for untagged manifests"
  type = object({
    days    = optional(number)
    enabled = optional(bool)
  })
  default = null
}

variable "log_analytics_workspace_name" {
  description = "The name of the Log Analytics workspace for diagnostic settings."
  type        = string
  default     = null
}

variable "storage_account_name" {
  description = "The name of the Azure Storage Account for diagnostic settings."
  type        = string
  default     = null
}

variable "acr_diag_logs" {
  description = "List of diagnostic logs to enable for the Azure Container Registry."
  type        = list(string)
  default     = []
}