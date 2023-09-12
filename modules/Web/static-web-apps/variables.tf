variable "location" {
  type        = string
  description = "Location"
}

variable "tags" {
  description = "Tags to be applied to resources (inclusive)"
  type        = object({
    environment         = string
    project        = string
  })
}

variable "extra_tags" {
  description = "extra tags to be applied to resources (in addition to the tags above)"
  type        = map(string)
  default     = {}
}

variable "resource_group" {
  type        = string
  description = "Resource group name"
}

variable "static_site_name" {
  type        = string
  description = "Static site name"
}

variable "identity_ids" {
  type        = list(string)
  description = "List of user assigned identity IDs (cannot be used with Free SKU)"
  default     = null
}

variable "sku_tier" {
  type        = string
  description = "SKU tier"
  default     = "Free"
  validation {
    condition     = contains(["Free", "Standard"], var.sku_tier)
    error_message = "SKU tier must be either Free or Standard"
  }
}

variable "sku_size" {
  type        = string
  description = "SKU size"
  default     = "Free"
  validation {
    condition     = contains(["Free", "Standard"], var.sku_size)
    error_message = "SKU size must be either Free or Standard"
  }
}