variable "queues" {
  description = "A list of queue configurations"
  type = list(object({
    name                              = string
    lock_duration                     = optional(string)
    max_message_size_in_kilobytes     = optional(number)
    max_size_in_megabytes             = optional(number)
    requires_duplicate_detection      = optional(bool)
    requires_session                  = optional(bool)
    default_message_ttl               = optional(string)
    dead_lettering_on_message_expiration = optional(bool)
    duplicate_detection_history_time_window = optional(string)
    max_delivery_count                = optional(number)
    status                            = optional(string)
    enable_batched_operations         = optional(bool)
    auto_delete_on_idle               = optional(string)
    enable_partitioning               = optional(bool)
    enable_express                    = optional(bool)
    forward_to                        = optional(string)
    forward_dead_lettered_messages_to = optional(string)
  }))
  default = []
}

variable "location" {
  description = "The location/region where the public IP will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the public IP will be created"
  type        = string
}

variable "name" {
  description = "Specifies the name of the Service Bus Namespace."
  type        = string
}

variable "sku" {
  description = "The SKU of the Service Bus Namespace. Possible values are Basic, Standard, and Premium."
  type        = string
}

variable "capacity" {
  description = "Specifies the Capacity Units for a Premium SKU namespace."
  type        = number
  default     = 1
}

variable "zone_redundant" {
  description = "Whether or not this Service Bus Namespace is Zone Redundant (only applicable to Premium SKU)."
  type        = bool
  default     = false
}

variable "identity" {
  description = "An identity block as documented below."
  type = object({
    type         = string
    identity_ids = list(string)
  })
  default = null
}

variable "customer_managed_key" {
  description = "A customer_managed_key block as documented below."
  type = object({
    key_vault_key_id                  = string
    identity_id                       = string
    infrastructure_encryption_enabled = bool
  })
  default = null
}

variable "network_rule_set" {
  description = "A network_rule_set block as documented below."
  type = object({
    default_action                 = string
    public_network_access_enabled  = bool
    trusted_services_allowed       = bool
    ip_rules                       = list(string)
    network_rules                  = object({
      subnet_id                              = string
      ignore_missing_vnet_service_endpoint   = bool
    })
  })
  default = null
}

variable "local_auth_enabled" {
  description = "Whether local authentication methods (like SAS) are enabled for this Service Bus Namespace."
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Whether public network access is allowed for this Service Bus Namespace."
  type        = bool
  default     = true
}

variable "minimum_tls_version" {
  description = "The minimum supported TLS version for the Service Bus Namespace. Possible values are 1.0, 1.1, and 1.2."
  type        = string
  default     = "1.2"
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