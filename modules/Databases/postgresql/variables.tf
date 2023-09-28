variable "postgresql_server_name" {
  description = "A name which will be pre-pended to the resources created"
  type        = string
}

variable "location" {
  description = "The location to deploy the service into"
  type        = string
}
  
variable "resource_group_name" {
  description = "The name of the resource group to deploy the service into"
  type        = string
}

variable "sku" {
  type        = string
  description = "Specifies the SKU of the database"
}

variable "postgresql_version" {
  description = "The version of PostgreSQL to deploy"
  type        = string
  default     = "11"
}

variable "subnet_id" {
  description = "The ID of a subnet to bind the database service into (must have 'Microsoft.Sql' enabled as a service_endpoint)"
  type        = string
}

variable "postgresql_database_name" {
  description = "The name of the database to create"
  type        = string
}

variable "administrator_login" {
  description = "The name of the administration user to create"
  type        = string
}

variable "administrator_login_password" {
  description = "The password of the administration user to create"
  type        = string
  sensitive   = true
}

variable "publicly_accessible" {
  description = "Whether to make this instance accessible over the internet"
  type        = bool
  default     = true
}

variable "additional_ip_allowlist" {
  description = "An optional list of CIDR ranges to allow traffic from"
  type        = list(any)
  default     = []
}

variable "max_allocated_storage_mb" {
  description = "The maximum size of the attached disk in MB"
  type        = number
  default     = 10240
}

variable "auto_grow_enabled" {
  description = "Whether the disk space should automatically expand"
  type        = bool
  default     = false
}

variable "backup_retention_days" {
  description = "The number of days to retain backups"
  type        = number
  default     = 7
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