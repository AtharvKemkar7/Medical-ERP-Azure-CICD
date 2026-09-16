locals {
  # Azure Container Registry names:
  # - must contain only lowercase letters and numbers
  # - must be globally unique
  # - must be between 5 and 50 characters
  registry_name = substr(
    lower(
      replace(
        replace(
          "${var.project}${var.resource_group_name}",
          "-",
          ""
        ),
        "_",
        ""
      )
    ),
    0,
    50
  )
}

resource "azurerm_container_registry" "main" {
  name                = local.registry_name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku           = var.sku
  admin_enabled = false

  public_network_access_enabled = true

  tags = var.tags
}