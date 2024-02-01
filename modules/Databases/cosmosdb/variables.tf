variable "cosmo_account_name" {
  description = "Name of the CosmosDB account"
}

variable "resource_group_name" {
  description = "Name of the Azure resource group"
}

variable "location" {
  description = "Azure region where the CosmosDB account will be created"
}
variable "network_acl_bypass_for_azure_services" {
  description = " If Azure services can bypass ACLs."
  default     = false
  type        = bool
}
variable "network_acl_bypass_ids" {
  description = "The list of resource Ids for Network Acl Bypass for this Cosmos DB account."
  type        = list(string)
  default     = null
}

variable "local_authentication_disabled" {
  description = " Disable local authentication and ensure only MSI and AAD can be used exclusively for authentication."
  type        = bool
  default     = false
}
variable "ip_range_filter" {
  default     = null
  description = "value"
  type        = string
}
variable "enabled_automatic_failover" {
  type        = bool
  description = "Enable automatic failover for this Cosmos DB account"
  default     = true
}


variable "tags" {
  description = "Tags to apply to the CosmosDB account"
  type        = map(string)
  default = {
    "Environment" = "development"
    "Project"     = "myproject"
  }
}

variable "extra_tags" {
  description = "Additional tags to merge with default tags"
  type        = optional(map(string))
  default     = {}
}

variable "offer_type" {
  description = "Offer type for the CosmosDB account"
  default     = "Standard"
}

variable "backup_type" {
  description = "Backup type for the CosmosDB account"

}

variable "create_mode" {
  description = "The creation mode for the CosmosDB Account. Possible values are Default and Restore."
  type        = string
  default     = "Default"

  validation {
    condition     = contains(["Default", "Restore"], var.create_mode) == true
    error_message = format("Invalid Value Entered for create_mode - %s", var.create_mode)
  }

}

variable "default_identity_type" {
  description = "The default identity for accessing Key Vault. Possible values are FirstPartyIdentity, SystemAssignedIdentity or UserAssignedIdentity"
  type        = optional(string)
  default     = "FirstPartyIdentity"
}

variable "kind" {
  description = "Specifies the Kind of CosmosDB to create - possible values are GlobalDocumentDB, MongoDB and Parse. Defaults to GlobalDocumentDB"
  default     = "GloabalDocumentDB"
  type        = optional(string)

  validation {
    condition     = contains(["GlobalDocumentDB", "MongoDB", "Parse"], var.kind) == true
    error_message = format("Invalid Value Entered - %s", var.kind)
  }
}

variable "consistency_policy" {
  description = " Specifies a consistency_policy resource, used to define the consistency policy for this CosmosDB account."
  type = list(object({
    consistency_level       = string
    max_interval_in_seconds = optional(number)
    max_staleness_prefix    = optional(number)
  }))

  default = [{
    consistency_level = "Eventual"
  }]

  validation {
    condition     = alltrue([for policy in consistency_policy : policy.consistency_level == "BoundedStaleness" && max_interval_in_seconds != "" && maxmax_staleness_prefix != ""])
    error_message = "The max_interval_in_seconds and max_staleness_prefix must be specified for consistency level 'BoundedStaleness'."
  }
}

variable "geo_location" {
  description = " Specifies a geo_location resource, used to define where data should be replicated with the failover_priority 0 specifying the primary location."
  type = list(object({
    location                = string
    failover_priority       = number
    zone_redundancy_enabled = optional(bool)
  }))
}


variable "public_network_access_enabled" {
  description = "Whether or not public network access is allowed for this CosmosDB account."
  type        = optional(bool)
  default     = false
}

variable "is_virtual_network_filter_enalbed" {
  description = "Enables virtual network filtering for this Cosmos DB account."
  type        = optional(bool)
}

variable "backup" {
  description = "List of backup configurations"
  type = list(object({
    type                = string
    interval_in_minutes = optional(number)
    retention_in_hours  = optional(number)
    storage_redundancy  = optional(string)
  }))

  default = []
}

variable "cors_rule" {
  description = "List of CORS rule configurations"
  type = list(object({
    allowed_headers    = list(string)
    allowed_methods    = list(string)
    allowed_origins    = list(string)
    exposed_headers    = list(string)
    max_age_in_seconds = optional(number)
  }))
  default = []
}


variable "identity" {
  description = "Managed Idenity to assign to CosmoDB Account. Can be UserAssigned, SystemAssigend or both"
  type = object({
    type     = string
    identity = optional(list)
  })
}
variable "virtual_network_rule" {
  default = null
  type = list(object({
    subnet_id                            = string
    ignore_missing_vnet_service_endpoint = bool
  }))
  description = "Defines which subnets are allowed to access this CosmosDB account. Each element in the list should have 'subnet_id' as a string specifying the subnet ID and 'ignore_missing_vnet_service_endpoint' as a boolean indicating whether to ignore missing VNet service endpoint."
}
variable "capabilities" {
  description = "The capabilities which should be enabled for this Cosmos DB account."
  type = list(object({
    name = string

  }))
  default = []
}
