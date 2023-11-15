variable "private_dns_zone_name" {
  type        = string
  description = "The name of the private DNS zone."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the private DNS zone."
}

variable "soa_record" {
  type        = object({
    email        = string
    expire_time  = optional(number)
    minimum_ttl  = optional(number)
    refresh_time = optional(number)
    retry_time   = optional(number)
    ttl          = optional(number)
  })
  default     = null
  description = "A map of SOA record properties."
}

variable "virtual_network_link" {
  type = map(object({
    name                 = string
    virtual_network_id   = string
    registration_enabled = bool
  }))
  default     = null
  description = "A map of virtual network link properties."
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