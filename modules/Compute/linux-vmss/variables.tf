variable "resource_group_name" {
  description = "The name of an existing resource group to be imported."
  type        = string
}

variable "virtual_machine_scale_set_name" {
  description = "Linux ScaleSet name"
  type        = string
}

variable "location" {
  description = "The location/region where the virtual machine will be created"
  type        = string
}

variable "vm_sku" {
  description = "Instance size to be provisioned"
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
  default     = "Standard_LRS"

  validation {
    condition     = (contains(["standard_lrs", "standardssd_lrs", "premium_lrs", "ultrassd_lrs"], lower(var.os_disk_storage_account_type)))
    error_message = "disk sku can only be \"Standard_LRS\", \"StandardSSD_LRS\", \"Premium_LRS\" or \"UltraSSD_LRS\"."
  }
}

# Credentials
variable "admin_username" {
  description = "Default Username"
  type        = string
}

variable "admin_password" {
  description = "Admin Password"
  type        = string
  sensitive   = true
}

variable "admin_ssh_public_key" {
  description = "Public SSH Key"
  type        = string
  default     = ""
  sensitive   = true
}

variable "instances" {
  description = "Number of instances."
  type        = number
}

variable "subnet_id" {
  description = "Subnet id for Scale Set."
  type        = string
}

variable "load_balancer_backend_address_pool_ids" {
  description = "Load balancer backend address pool ids."
  type        = list(string)
}

variable "enable_health_probe_id" {
  description = "Enables health check probe id for Scale Set"
  type        = bool
  default     = false
}

variable "health_probe_id" {
  description = "Health probe id. IE: azurerm_lb_probe."
  type        = string
  default     = null
}

variable "custom_data" {
  description = "custom_data."
  type        = string
  default     = "# noop"
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

variable "enable_public_ip_address" {
  description = "VM image"
  type        = bool
  default     = false
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