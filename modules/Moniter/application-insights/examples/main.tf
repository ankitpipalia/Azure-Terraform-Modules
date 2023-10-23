module "application_insights" {
  source = "registry.terraform.io/T-Systems-MMS/application-insights/azurerm"
  application_insights = {
    function_app = {
      location                   = "westeurope"
      resource_group_name        = "service-env-rg"
      application_type           = "Node.JS"
      internet_ingestion_enabled = true
      internet_query_enabled     = true
      retention_in_days          = "90"
      tags = {
        service = "service_name"
      }
    }
  }
}
