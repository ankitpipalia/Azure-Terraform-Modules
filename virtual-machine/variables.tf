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
  description = "Public SSH Key"
  type        = string
  default     = ""
  sensitive   = true
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

# VM Identity
variable "identity_type" {
  description = "The Managed Service Identity Type of this Virtual Machine. Possible values are SystemAssigned (where Azure will generate a Managed Identity for you), UserAssigned (where you can specify the Managed Identities ID)."
  type        = string
  default     = "SystemAssigned"

  validation {
    condition     = (contains(["systemassigned", "userassigned"], lower(var.identity_type)))
    error_message = "The identity type can only be \"UserAssigned\" or \"SystemAssigned\"."
  }
}

variable "identity_ids" {
  description = "Specifies a list of user managed identity ids to be assigned to the VM"
  type        = list(string)
  default     = []
}

variable "diagnostics_storage_account_uri" {
  description = "The Storage Account's Blob Endpoint which should hold the virtual machine's diagnostic files."
  type        = string
  default     = null
}

variable "enable_boot_diagnostics" {
  description = "Whether to enable boot diagnostics on the virtual machine."
  type        = bool
  default     = false
}

variable "tags" {
  description = "tags to be applied to resources"
  type        = map(string)
  default     = {}
}

