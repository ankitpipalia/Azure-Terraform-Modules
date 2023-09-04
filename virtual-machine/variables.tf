variable "vm_name" {
  description = "The name of the virtual machine"
  type        = string
}

variable "location" {
  description = "The location/region where the virtual machine will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the virtual machine will be created"
  type        = string
}

variable "vm_size" {
  description = "The size of the virtual machine"
  type        = string
}

variable "image_publisher" {
  description = "The publisher of the virtual machine image"
  type        = string
}

variable "image_offer" {
  description = "The offer of the virtual machine image"
  type        = string
}

variable "image_sku" {
  description = "The SKU of the virtual machine image"
  type        = string
}

variable "image_version" {
  description = "The version of the virtual machine image"
  type        = string
}

variable "os_disk_name" {
  description = "The name of the OS disk"
  type        = string
}

variable "os_disk_caching" {
  description = "The caching type of the OS disk"
  type        = string
}

variable "os_disk_create_option" {
  description = "The create option for the OS disk"
  type        = string
}

variable "os_disk_managed_disk_type" {
  description = "The managed disk type for the OS disk"
  type        = string
}

variable "os_disk_size_gb" {
  description = "The size of the OS disk in GB"
  type        = number
}

variable "computer_name" {
  description = "The computer name of the virtual machine"
  type        = string
}

variable "admin_username" {
  description = "The admin username for the virtual machine"
  type        = string
}

variable "admin_password" {
  description = "The admin password for the virtual machine"
  type        = string
}

variable "disable_password_authentication" {
  description = "Flag to disable password authentication for SSH"
  type        = bool
}

variable "ssh_key_path" {
  description = "The path to the SSH public key file"
  type        = string
}

variable "ssh_key_data" {
  description = "The SSH public key data"
  type        = string
}

variable "boot_diagnostics_enabled" {
  description = "Flag to enable boot diagnostics"
  type        = bool
}

variable "boot_diagnostics_storage_uri" {
  description = "The URI of the storage account for boot diagnostics"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to resources (inclusive)"
  type        = object({
    environment         = string
    project        = string
  })
}

variable "nic_name" {
  description = "The name of the network interface"
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
  description = "The private IP address allocation method"
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
