variable "public_ip_name" {
  description = "The name of the public IP"
  type        = string
}

variable "location" {
  description = "The location/region where the public IP will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the public IP will be created"
  type        = string
}

variable "allocation_method" {
  description = "The allocation method for the public IP"
  type        = string
  default     = "Dynamic"
}

variable "sku" {
  description = "The SKU (pricing tier) for the public IP"
  type        = string
  default     = "Basic"
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