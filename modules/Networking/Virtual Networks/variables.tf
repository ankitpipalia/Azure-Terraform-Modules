variable "address_space" {
  description = "The address space of the virtual network"
  type        = list(string)
}

variable "virtual_network_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "tags" {
  description = "tags to be applied to resources"
  type        = map(string)
  default     = {}
}

variable "location" {
  description = "The location of the virtual network"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}