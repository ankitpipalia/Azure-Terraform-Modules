variable "virtual_machine_name" {
  description = "The name of the virtual machine"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the virtual machine will be created"
  type        = string
}

variable "location" {
  description = "The location/region where the virtual machine will be created"
  type        = string
}

variable "vm_size" {
  description = "Instance size to be provisioned"
  type        = string
}

# Credentials
variable "admin_username" {
  description = "Default Username"
  type        = string
}

variable "admin_password" {
  description = "Default Password"
  type        = string
  sensitive   = true
}

variable "admin_ssh_public_key" {
  description = "SSH Public Key"
  type        = string
  default     = null
}

variable "network_interface_id" {
  description = "Network Interface ID"
  type        = string
}

# Operating System Disck
variable "os_disk_caching" {
  description = "Type of caching to use on the OS disk - Options: None, ReadOnly or ReadWrite"
  type        = string
  default     = "ReadWrite"

  validation {
    condition     = (contains(["none", "readonly", "readwrite"], lower(var.os_disk_caching)))
    error_message = "OS Disk cache can only be \"None\", \"ReadOnly\" or \"ReadWrite\"."
  }
}

variable "os_disk_storage_account_type" {
  description = "Type of storage account to use with the OS disk - Options: Standard_LRS, StandardSSD_LRS or Premium_LRS"
  type        = string
  default     = "StandardSSD_LRS"

  validation {
    condition     = (contains(["standard_lrs", "standardssd_lrs", "premium_lrs", "ultrassd_lrs"], lower(var.os_disk_storage_account_type)))
    error_message = "Public IP sku can only be \"Standard_LRS\", \"StandardSSD_LRS\", \"Premium_LRS\" or \"UltraSSD_LRS\"."
  }
}

# Operating System
variable "source_image_publisher" {
  description = "Operating System Publisher"
  type        = string
  default     = null
}

variable "source_image_offer" {
  description = "Operating System Name"
  type        = string
  default     = null
}

variable "source_image_sku" {
  description = "Operating System SKU"
  type        = string
  default     = null
}

variable "source_image_version" {
  description = "Operating System Version"
  type        = string
  default     = null
}

variable "source_image_id" {
  description = "Operating System Image ID"
  type        = string
  default     = null
}

variable "boot_diagnostics_enabled" {
  description = "Enable Boot Diagnostics"
  type        = bool
  default     = false
}

variable "boot_diagnostics_storage_uri" {
  description = "Boot Diagnostics Storage URI"
  type        = string
  default     = null
}

variable "availability_zone" {
  description = "Availability Zone"
  type        = string
  default     = null
}

variable "ultra_ssd_enabled" {
  description = "Enable UltraSSD"
  type        = bool
  default     = false
}

variable "identity_type" {
  description = "Identity Type"
  type        = string
  default     = null
}
  
variable "identity_ids" {
  description = "Identity IDs"
  type        = list(string)
  default     = null
}

variable "tags" {
  description = "tags to be applied to resources"
  type        = map(string)
}

