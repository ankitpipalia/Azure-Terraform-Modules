variable "autoscale_setting_name" {
  description = "The name of the autoscale setting"
  type        = string
}

variable "default_capacity" {
  description = "The default capacity of the profile"
  type        = number
}

variable "location" {
  description = "The location of the autoscale setting"
  type        = string
}

variable "maximum_capacity" {
  description = "The maximum capacity of the profile"
  type        = number
}

variable "metric_name" {
  description = "The name of the metric trigger"
  type        = string
}

variable "metric_namespace" {
  description = "The namespace of the metric trigger"
  type        = string
}

variable "metric_resource_id" {
  description = "The resource id of the metric trigger"
  type        = string
}

variable "minimum_capacity" {
  description = "The minimum capacity of the profile"
  type        = number
}

variable "operator" {
  description = "The operator of the metric trigger"
  type        = string
}

variable "profile_name" {
  description = "The name of the profile"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the autoscale setting"
  type        = string
}

variable "scale_cooldown" {
  description = "The cooldown of the scale action"
  type        = string
}

variable "scale_direction" {
  description = "The direction of the scale action"
  type        = string
}

variable "scale_type" {
  description = "The type of the scale action"
  type        = string
}

variable "scale_value" {
  description = "The value of the scale action"
  type        = number
}

variable "statistic" {
  description = "The statistic of the metric trigger"
  type        = string
}

variable "target_resource_id" {
  description = "The resource id of the target resource"
  type        = string
}

variable "threshold" {
  description = "The threshold of the metric trigger"
  type        = number
}

variable "time_aggregation" {
  description = "The time aggregation of the metric trigger"
  type        = string
}

variable "time_grain" {
  description = "The time grain of the metric trigger"
  type        = string
}

variable "time_window" {
  description = "The time window of the metric trigger"
  type        = string
}