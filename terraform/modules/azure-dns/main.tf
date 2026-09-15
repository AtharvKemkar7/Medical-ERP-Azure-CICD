locals {
  dns_zone_name = trimsuffix(var.domain_name, ".")
}

resource "azurerm_dns_zone" "main" {
  name                = local.dns_zone_name
  resource_group_name = var.resource_group_name

  tags = var.tags
}

resource "azurerm_dns_a_record" "root" {
  name                = "@"
  zone_name           = azurerm_dns_zone.main.name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [var.ingress_ip_address]

  count = var.ingress_ip_address != "" ? 1 : 0
}

resource "azurerm_dns_cname_record" "frontend" {
  name                = "www"
  zone_name           = azurerm_dns_zone.main.name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  record              = trimsuffix(
    replace(var.frontend_endpoint, "https://", ""),
    "/"
  )

  count = var.frontend_endpoint != "" ? 1 : 0
}

resource "azurerm_dns_cname_record" "additional" {
  for_each = {
    for domain in var.domain_names :
    domain => domain
    if domain != var.domain_name
  }

  name                = trimsuffix(each.value, ".")
  zone_name           = azurerm_dns_zone.main.name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  record              = trimsuffix(
    replace(var.frontend_endpoint, "https://", ""),
    "/"
  )

  count = var.frontend_endpoint != "" ? 1 : 0
}