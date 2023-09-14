variable "mssql_server_name" {
  type        = string
  description = "The name of the Microsoft SQL Server"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Microsoft SQL Server"
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists"
}

variable "administrator_login" {
  type        = string
  description = "The administrator login name for the server"
}

variable "administrator_login_password" {
  type        = string
  description = "The password associated with the admin_username"
}

variable "azure_ad_admin_login" {
  type        = string
  description = "The login username of the Azure AD Administrator of this SQL Server."
}

variable "azure_ad_admin_object_id" {
  type        = string
  description = "The object id of the Azure AD Administrator of this SQL Server"
}

variable "custom_mssql_server_name" {
  type        = string
  description = "The name of the Microsoft SQL Server"
  default     = null
}

variable "server_version" {
  type        = string
  description = "Server version"
  default     = "12.0"
}

variable "connection_policy" {
  type        = string
  description = "The connection policy the server will use: [Default|Proxy|Redirect]"
  default     = "Default"
}

variable "minimum_tls_version" {
  type        = string
  description = "The Minimum TLS Version for all SQL Database and SQL Data Warehouse databases associated with the server: [1.0|1.1|1.2]"
  default     = "1.2"
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether public network access is allowed for this server"
  default     = false
}

variable "tags" {
  description = "Tags to be applied to resources (inclusive)"
  type        = object({
    environment         = string
    project        = string
  })
}

variable "extra_tags" {
  description = "extra tags to be applied to resources (in addition to the tags above)"
  type        = map(string)
  default     = {}
}

variable "ip_rules" {
  type        = map(string)
  description = "Map of IP addresses permitted for access to DB"
  default     = {}
}

variable "tde_encryption_enabled" {
  type        = bool
  description = "Boolean flag that enabled Transparent Data Encryption of Server"
  default     = false
}

variable "tde_key_permissions" {
  type        = list(string)
  description = "List of tde key permissions"
  default = [
    "Get",
    "WrapKey",
    "UnwrapKey",
    "GetRotationPolicy",
    "SetRotationPolicy"
  ]
}

variable "key_vault_id" {
  type        = string
  description = "Key Vault ID"
  default     = null
}

variable "key_vault_key_id" {
  type        = string
  description = "Key Vault Key id for transparent data encryption of server"
  default     = null
}

variable "auto_rotation_enabled" {
  type        = bool
  description = "Server will continuously check the key vault for any new versions of the key"
  default     = true
}

variable "mssql_defender_state" {
  description = "Manages Microsoft Defender state on the mssql server"
  type        = string
  default     = null

  validation {
    condition     = var.mssql_defender_state != null ? contains(["Enabled", "Disabled"], var.mssql_defender_state) : true
    error_message = "The only allowed values for variable are: 'Enabled' or 'Disabled"
  }
}

variable "firewall_rule_name" {
  type        = string
  description = "The name of the firewall rule"
  default     = null
}