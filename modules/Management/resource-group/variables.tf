variable "location" {
  description = "Azure Region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
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