variable "address_space" {
  description = "The address space of the virtual network"
  type        = list(string)
}

variable "virtual_network_name" {
  description = "The name of the virtual network"
  type        = string
  default     = null
}

variable "location" {
  description = "The location of the virtual network"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "dns_servers" {
  description = "The DNS servers"
  type        = list(string)
  default     = []
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
  type = string
}

variable "project" {
  description = "project name"
  type = string
}