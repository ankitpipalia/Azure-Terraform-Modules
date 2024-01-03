variable "service_plan_name" {
  type        = string
  description = "The name of the App Service Plan"
  default     = null
}

variable "location" {
  type        = string
  description = "The Azure Region in which all resources in this example should be created."
}

variable "resource_group_name" {
  type        = string
  description = "The Azure Region in which all resources in this example should be created."
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

variable "os_type" {
  type        = string
  description = "OS type: Windows, Linux, or WindowsContainer"
  default     = "Linux"
}

variable "sku_name" {
  type        = string
  description = "The SKU for the plan"
  default     = "P1v3"
}

variable "per_site_scaling_enabled" {
  type        = bool
  default     = false
  description = "Enable per site scaling"
}

variable "worker_count" {
  type        = number
  default     = null
  description = "Number of workers"
}