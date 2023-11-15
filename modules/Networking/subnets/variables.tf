variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network"
  type        = string  
}

variable "subnets" {
  description = "The subnets to create"
  
  type = list(object({
    name           = string
    address_prefix = string
    service_endpoints = optional(set(string))
    
    delegation = optional(object({
      name          = string
      service_name  = string 
      actions       = list(string)
    }))
  }))
}