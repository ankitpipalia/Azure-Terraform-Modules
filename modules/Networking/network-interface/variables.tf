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

variable "tags" {
  description = "tags to be applied to resources"
  type        = map(string)
  default     = {}
}