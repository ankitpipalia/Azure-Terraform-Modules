resource "azurerm_user_assigned_identity" "uai" {

  resource_group_name = var.resource_group_name
  location            = var.location
  name                = coalesce(var.identity_name, "${var.tags.project}-${var.tags.environment}-identity")

  tags = merge(
    {
      "Environment" = var.tags.environment,
      "Project"     = var.tags.project
    },
    var.extra_tags
  )

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}