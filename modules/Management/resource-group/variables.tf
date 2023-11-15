variable "location" {
  description = "Azure Region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = null
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

variable "environment" {
  description = "environment name of the project"
  type        = string
}

variable "project" {
  description = "project name"
  type        = string
}
