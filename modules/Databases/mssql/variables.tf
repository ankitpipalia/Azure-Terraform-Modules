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
  default     = null
  description = "The administrator login name for the server"
}

variable "administrator_login_password" {
  type        = string
  sensitive   = true
  description = "The password associated with the admin_username"
}
variable "transparent_data_encryption_key_vault_key_id" {
  type        = string
  default     = null
  description = "The fully versioned Key Vault Key"
}
variable "outbound_network_restriction_enabled" {
  type        = bool
  default     = false
  description = "Whether outbound network traffic is restricted for this server. "
}
variable "primary_user_assigned_identity_id" {
  type        = string
  default     = null
  description = "Specifies the primary user managed identity id."

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
variable "identity_ids" {
  type        = list(string)
  default     = null
  description = " Specifies a list of User Assigned Managed Identity IDs to be assigned to this SQL Server."
}

variable "connection_policy" {
  type        = string
  description = "The connection policy the server will use: [Default|Proxy|Redirect]"
  default     = "Default"
}
variable "tenant_id" {
  type        = string
  default     = null
  description = "The tenant id of the Azure AD Administrator of this SQL Server."
}
variable "azuread_authentication_only" {
  type        = bool
  description = "Specifies whether only AD Users and administrators "
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

variable "mssql_database_name" {
  type        = string
  description = "Name of MSSQL database"
}

variable "collation" {
  type        = string
  description = "Specifies the collation of the database"
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "sku" {
  type        = string
  description = "Specifies the SKU of the database"
}

variable "max_size" {
  type        = string
  description = "The max size of the database in gigabytes"
}

variable "min_capacity" {
  type        = string
  description = "The min size of the database in gigabytes"
}

variable "autopause_delay" {
  type        = number
  description = "Time in minutes after which database is automatically paused. A value of -1 means that automatic pause is disabled"
  default     = -1
}

variable "retention_days" {
  type        = number
  description = "Specifies the number of days to keep in the Threat Detection audit logs."
  default     = 3
}

variable "create_mode" {
  type        = string
  description = "Type of create mode selected in database config object"
  default     = "Default"
}

variable "creation_source_database_id" {
  type        = string
  description = "This variable is used in case 'create_mode'='Copy'"
  default     = null
}

variable "storage_account_type" {
  type        = string
  description = "Specifies the storage account type used to store backups for this database"
}

variable "databases" {
  type        = map(map(string))
  description = "Map of databases"
  default     = {}
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "Log Analytics Workspace ID"
  default     = ""
}

variable "log_category_list" {
  type = list(any)
  default = [
    "QueryStoreRuntimeStatistics",
    "QueryStoreWaitStatistics",
    "Errors",
    "DatabaseWaitStatistics",
    "Timeouts",
    "Blocks",
    "Deadlocks"
  ]
  description = "Category list log"
}

variable "category_list_metrics" {
  type = list(any)
  default = [
    "Basic",
    "WorkloadManagement"
  ]
  description = "Category list metrics"
}

variable "log_retention_days" {
  default     = 7
  type        = number
  description = "Retention log policy days"
}

variable "metric_retention_days" {
  default     = 7
  type        = number
  description = "Retention metric policy days"
}

variable "destination_type" {
  type        = string
  default     = "Dedicated"
  description = "Log analytics destination type"
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
variable "extended_auditing_storage_endpoint" {
  description = "The storage endpoint for extended auditing logs"
  type        = string
}

variable "extended_auditing_storage_account_access_key" {
  description = "The storage account access key for extended auditing logs"
  type        = string
}

variable "extended_auditing_retention_days" {
  description = "The number of days to retain extended auditing logs"
  type        = number
}

variable "extended_auditing_audit_actions" {
  description = "The list of actions to be audited for extended auditing"
  type        = list(string)
}

variable "storage_account_access_key_is_secondary" {
  type        = bool
  default     = false
  description = "Specifies whether the provided access key is for the secondary storage account key. Set this to true if using the secondary key; otherwise, leave it as false."
}
