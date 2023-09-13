variable "src_peering_name" {
  type        = string
  description = "The name of the virtual network peering in source VPC"
}

variable "src_resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the virtual network peering"
}

variable "src_virtual_network_name" {
  type        = string
  description = "The name of the source virtual network"
}

variable "src_virtual_network_id" {
  type        = string
  description = "The full Azure resource ID of the source virtual network"
}

variable "dst_peering_name" {
  type        = string
  description = "The name of the virtual network peering in destination VPC"
}

variable "dst_resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the virtual network peering"
}

variable "dst_virtual_network_name" {
  type        = string
  description = "The name of the destination virtual network"
}

variable "dst_virtual_network_id" {
  type        = string
  description = "The full Azure resource ID of the destination virtual network"
}

variable "allow_virtual_network_access" {
  type        = bool
  default     = true
  description = "Controls if the VMs in the remote virtual network can access VMs in the local virtual network"
}

variable "allow_forwarded_traffic" {
  type        = bool
  default     = false
  description = "Controls if forwarded traffic from VMs in the remote virtual network is allowed"
}

variable "allow_gateway_transit" {
  type        = bool
  default     = false
  description = "Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network"
}

variable "use_remote_gateways" {
  type        = bool
  default     = false
  description = "Controls if remote gateways can be used on the local virtual network"
}