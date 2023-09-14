variable "network_interface_name" {
  description = "The name of the network interface"
  type        = string
}

variable "location" {
  description = "The location of the network interface"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "ip_configuration_name" {
  description = "The name of the IP configuration"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet"
  type        = string
}

variable "private_ip_address_allocation" {
  description = "The allocation method for the private IP address"
  type        = string
}

variable "private_ip_address" {
  description = "The private IP address"
  type        = string
}

variable "public_ip_address_id" {
  description = "The ID of the public IP address"
  type        = string
}

variable "dns_servers" {
  description = "The DNS servers"
  type        = list(string)
  default     = []
}

variable "enable_accelerated_networking" {
  description = "Enable accelerated networking"
  type        = bool
  default     = false
}

variable "enable_ip_forwarding" {
  description = "Enable IP forwarding"
  type        = bool
  default     = false
}

variable "internal_dns_name_label" {
  description = "The internal DNS name label"
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