locals {
  storage_account_name = substr(
    lower(
      regexreplace(
        "${var.project}${var.environment}frontend",
        "[^a-z0-9]",
        ""
      )
    ),
    0,
    24
  )

  cdn_endpoint_name = substr(
    lower(
      regexreplace(
        "${var.project}-${var.environment}-frontend-cdn",
        "[^a-z0-9-]",
        ""
      )
    ),
    0,
    50
  )
}

resource "azurerm_storage_account" "frontend" {
  name                     = local.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version                 = "TLS1_2"
  https_traffic_only_enabled      = true
  public_network_access_enabled   = true
  allow_nested_items_to_be_public = false

  static_website {
    index_document     = "index.html"
    error_404_document = "index.html"
  }

  tags = var.tags
}

resource "azurerm_cdn_profile" "frontend" {
  name                = "${var.project}-${var.environment}-cdn-profile"
  resource_group_name = var.resource_group_name
  location            = var.location

  sku = "Standard_Microsoft"

  tags = var.tags
}

resource "azurerm_cdn_endpoint" "frontend" {
  name                = local.cdn_endpoint_name
  profile_name        = azurerm_cdn_profile.frontend.name
  resource_group_name = var.resource_group_name
  location            = var.location

  origin_host_header = azurerm_storage_account.frontend.primary_web_host

  origin {
    name      = "static-website-origin"
    host_name = azurerm_storage_account.frontend.primary_web_host
  }

  is_http_allowed  = false
  is_https_allowed = true

  querystring_caching_behaviour = "IgnoreQueryString"

  global_delivery_rule {
    cache_expiration_action {
      behavior = "Override"
      duration = "1.00:00:00"
    }

    modify_response_header_action {
      action = "Append"
      name   = "Cache-Control"
      value  = "public, max-age=86400"
    }
  }

  tags = var.tags
}