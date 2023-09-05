variable "location" {
  description = "Azure Region"
  type        = string
}

variable "tags" {
  description = "tags to be applied to resources"
  type        = map(string)
  default     = {}
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}