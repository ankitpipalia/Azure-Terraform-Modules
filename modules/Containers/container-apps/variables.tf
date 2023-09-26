variable "container_app_environment_name" {
  type        = string
  description = "(Required) The name of the container apps managed environment. Changing this forces a new resource to be created."
  nullable    = false
}

variable "container_apps" {
  type = map(object({
    name          = string
    revision_mode = string

    template = object({
      containers = set(object({
        name    = string
        image   = string
        args    = optional(list(string))
        command = optional(list(string))
        cpu     = string
        memory  = string
        env = optional(set(object({
          name        = string
          secret_name = optional(string)
          value       = optional(string)
        })))
        liveness_probe = optional(object({
          failure_count_threshold = optional(number)
          header = optional(object({
            name  = string
            value = string
          }))
          host             = optional(string)
          initial_delay    = optional(number, 1)
          interval_seconds = optional(number, 10)
          path             = optional(string)
          port             = number
          timeout          = optional(number, 1)
          transport        = string
        }))
        readiness_probe = optional(object({
          failure_count_threshold = optional(number)
          header = optional(object({
            name  = string
            value = string
          }))
          host                    = optional(string)
          interval_seconds        = optional(number, 10)
          path                    = optional(string)
          port                    = number
          success_count_threshold = optional(number, 3)
          timeout                 = optional(number)
          transport               = string
        }))
        startup_probe = optional(object({
          failure_count_threshold = optional(number)
          header = optional(object({
            name  = string
            value = string
          }))
          host             = optional(string)
          interval_seconds = optional(number, 10)
          path             = optional(string)
          port             = number
          timeout          = optional(number)
          transport        = string
        }))
        volume_mounts = optional(object({
          name = string
          path = string
        }))
      }))
      max_replicas    = optional(number)
      min_replicas    = optional(number)
      revision_suffix = optional(string)

      volume = optional(set(object({
        name         = string
        storage_name = optional(string)
        storage_type = optional(string)
      })))
    })

    ingress = optional(object({
      allow_insecure_connections = optional(bool, false)
      external_enabled           = optional(bool, false)
      target_port                = number
      transport                  = optional(string)
      traffic_weight = object({
        label           = optional(string)
        latest_revision = optional(string)
        revision_suffix = optional(string)
        percentage      = number
      })
    }))

    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))

    dapr = optional(object({
      app_id       = string
      app_port     = number
      app_protocol = optional(string)
    }))

    registry = optional(list(object({
      server               = string
      username             = optional(string)
      password_secret_name = optional(string)
      identity             = optional(string)
    })))
  }))
  description = "The container apps to deploy."
  nullable    = false

  validation {
    condition     = length(var.container_apps) >= 1
    error_message = "At least one container should be provided."
  }
}


variable "location" {
  type        = string
  description = "(Required) The location this container app is deployed in. This should be the same as the environment in which it is deployed."
  nullable    = false
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which the resources will be created."
  nullable    = false
}

variable "container_app_environment_infrastructure_subnet_id" {
  type        = string
  default     = null
  description = "(Optional) The existing subnet to use for the container apps control plane. Changing this forces a new resource to be created."
}

variable "container_app_environment_internal_load_balancer_enabled" {
  type        = string
  default     = null
  description = "(Optional) Should the Container Environment operate in Internal Load Balancing Mode? Defaults to `false`. Changing this forces a new resource to be created."
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

variable "container_app_secrets" {
  type = map(list(object({
    name  = string
    value = string
  })))
  default     = {}
  description = "(Optional) The secrets of the container apps. The key of the map should be aligned with the corresponding container app."
  nullable    = false
  sensitive   = true
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "(Optional) The ID of the Log Analytics Workspace to use for logging. Changing this forces a new resource to be created."
  default     = null
}