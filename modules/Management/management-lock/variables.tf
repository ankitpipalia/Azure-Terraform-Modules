variable "name" {
  description = "Specifies the name of the Management Lock."
  type        = string
}

variable "scope" {
  description = "Specifies the scope at which the Management Lock should be created."
  type        = string
}

variable "lock_level" {
  description = "Specifies the Level to be used for this Lock."
  type        = string
  validation {
    condition     = contains(["CanNotDelete", "ReadOnly"], var.lock_level)
    error_message = "Valid values for lock_level are CanNotDelete or ReadOnly."
  }
}

variable "notes" {
  description = "(Optional) Specifies some notes about the lock."
  type        = string
  default     = null
}