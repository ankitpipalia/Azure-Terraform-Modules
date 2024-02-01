variable "postgres_name" {
  type        = string
  description = "The name which should be used for this Azure Cosmos DB for PostgreSQL Cluster."
}
variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group where the Azure Cosmos DB for PostgreSQL Cluster "
}
variable "location" {
  type        = string
  description = "The Azure Region where the Azure Cosmos DB for PostgreSQL Cluster ."
}
variable "administrator_login_password" {
  type        = string
  sensitive   = true
  description = "The password of the administrator login."
}
variable "coordinator_public_ip_access_enabled" {
  type        = bool
  default     = true
  description = "Coordinate when public id is enabled"
}
variable "coordinator_storage_quota_in_mb" {
  type        = number
  default     = null
  description = "The coordinator storage allowed for the Azure Cosmos DB for PostgreSQL Cluster.  "
}
variable "coordinator_vcore_count" {
  type        = number
  default     = null
  description = "The coordinator vCore count for the Azure Cosmos DB for PostgreSQL Cluster. "
}
variable "node_count" {
  type        = number
  description = "The worker node count of the Azure Cosmos DB for PostgreSQL Cluster"
  validation {
    condition     = var.node_count != 1 && var.node_count >= 0 && var.node_count <= 20
    error_message = "The value is between 0 and 20 except 1."
  }
}
variable "citus_version" {
  type        = string
  default     = null
  description = " The citus extension version on the Azure Cosmos DB for PostgreSQL Cluster."
}
variable "coordinator_server_edition" {
  type        = string
  description = "value"
  default     = "GeneralPurpose"
}
variable "ha_enabled" {
  type        = bool
  default     = false
  description = "value"
}
variable "maintenance_window" {
  type        = map(number)
  default     = null
  description = "It defines day,hour and minute in a week"
}

variable "node_public_ip_access_enabled" {
  type        = bool
  default     = false
  description = "Node public ip access is enabled"
}
variable "node_server_edition" {
  type        = string
  default     = "MemoryOptimized"
  description = "The edition of the node server. "
}
variable "node_storage_quota_in_mb" {
  type        = number
  default     = null
  description = "The storage quota in MB on each worker node."
}
variable "point_in_time_in_utc" {
  type        = string
  default     = null
  description = "The date and time in UTC (ISO8601 format) for the Azure Cosmos DB for PostgreSQL cluster restore."
}
variable "preferred_primary_zone" {
  type        = string
  default     = null
  description = "The preferred primary availability zone for the Azure Cosmos DB for PostgreSQL cluster."
}
variable "shards_on_coordinator_enabled" {
  type        = bool
  default     = null
  description = "Is shards on coordinator enabled for the Azure Cosmos DB for PostgreSQL cluster."
}
variable "source_location" {
  type        = string
  default     = null
  description = "The Azure region of the source Azure Cosmos DB for PostgreSQL cluster for read replica clusters."
}
variable "source_resource_id" {
  type        = string
  default     = null
  description = "The resource ID of the source Azure Cosmos DB for PostgreSQL cluster for read replica clusters."
}
variable "sql_version" {
  type        = number
  default     = null
  description = "The major PostgreSQL version on the Azure Cosmos DB for PostgreSQL cluster"
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


#postgresql_coordinator_configuration
variable "postgres_coordination_name" {
  type        = string
  description = "The name of the Coordinator Configuration on Azure Cosmos DB for PostgreSQL Cluster."
}
variable "value" {
  type        = string
  description = " The value of the Coordinator Configuration on Azure Cosmos DB for PostgreSQL Cluster."
}


# postgresql_firewall_rule
variable "firewall_rules" {
  type = map(object({
    start_ip_address = string
    end_ip_address   = string
  }))
  default     = {}
  description = "Set firewall rules"
}


#postgresql_node_configuration
variable "postgres_node_name" {
  type = string
}



#postgresql_role
variable "postgres_role_name" {
  type        = string
  description = "The name which should be used for this Azure Cosmos DB for PostgreSQL Role"

}
variable "password" {
  type        = string
  sensitive   = true
  description = "The password of the Azure Cosmos DB for PostgreSQL Role."
}
