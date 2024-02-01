variable "keyvault_name" {
  type        = string
  description = "The name of the Keyvault where the DB credentials are stored"
  default     = null
}
variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group where the MySQL Flexible Server should exist"

}
variable "location" {
  type        = string
  description = "The Azure Region where the MySQL Flexible Server should exist"

}
variable "mysql_server_name" {
  type        = string
  description = "The name which should be used for this MySQL Flexible Server."

}
variable "administrator_login" {
  type        = string
  description = "The Administrator login for the MySQL Flexible Server. Required when create_mode is Default"

}

variable "administrator_password" {
  type        = string
  description = "The Password associated with the administrator_login for the MySQL Flexible Server. Required when create_mode is Default"
  sensitive   = true
}

variable "store_db_password_in_keyvault" {
  type        = bool
  description = "Should the DB password be stored in Keyvault? Defaults to false"
  default     = false
}

variable "key_vault_id" {
  type        = string
  description = "The ID of the Keyvault where the DB credentials are stored"
  default     = null
}

variable "backup_retention_days" {
  type        = number
  description = " The backup retention days for the MySQL Flexible Server. Possible values are between 1 and 35 days. Defaults to 7"
  default     = 7
}

variable "create_mode" {
  type        = string
  description = "The creation mode which can be used to restore or replicate existing servers. Possible values are Default, PointInTimeRestore, GeoRestore, and Replica"
  default     = "Default"
}

variable "geo_redundant_backup_enabled" {
  type        = bool
  description = "Should geo redundant backup enabled? Defaults to false"
  default     = false
}

variable "server_sku_name" {
  type        = string
  description = "sku_name should start with SKU tier B (Burstable), GP (General Purpose), MO (Memory Optimized) like B_Standard_B1s"
}

variable "mysql_version" {
  type        = string
  description = "The version of the MySQL Flexible Server to use. Possible values are 5.7, and 8.0.21."
  default     = "8.0.21"
}

variable "zone" {
  type        = string
  description = "Specifies the Availability Zone in which this MySQL Flexible Server should be located. Possible values are 1, 2 and 3."
  default     = "1"
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

variable "database_name" {
  type        = string
  description = "The name of the database to be created on the MySQL Flexible Server"
}

variable "collation" {
  type        = string
  description = "The collation of the database to be created on the MySQL Flexible Server"
  default     = "utf8_general_ci"
}

variable "charset" {
  type        = string
  description = "The charset of the database to be created on the MySQL Flexible Server"
  default     = "utf8"
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Whether to enable the extended auditing policy."
}
variable "storage_endpoint" {
  type        = string
  default     = null
  description = "he blob storage endpoint (e.g. https://example.blob.core.windows.net). This blob storage will hold all extended auditing logs."
}

variable "retention_in_days" {
  type        = number
  default     = 0
  description = " The number of days to retain logs for in the storage account. "
}
variable "log_monitoring_enabled" {
  type        = bool
  default     = true
  description = " Enable audit events to Azure Monitor?"
}
