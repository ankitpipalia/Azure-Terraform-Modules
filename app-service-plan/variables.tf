variable "App_Service_Plan_Config" {
  description = "A list of maps containing configurations for App Service Plans"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    os_type             = string
    sku                 = string
  }))
}

