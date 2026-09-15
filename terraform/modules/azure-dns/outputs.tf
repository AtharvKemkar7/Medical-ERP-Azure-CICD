output "dns_zone_id" {
  description = "Azure DNS zone resource ID."
  value       = azurerm_dns_zone.main.id
}

output "dns_zone_name" {
  description = "Azure DNS zone name."
  value       = azurerm_dns_zone.main.name
}

output "name_servers" {
  description = "Azure DNS name servers."
  value       = azurerm_dns_zone.main.name_servers
}

output "resource_group_name" {
  description = "Resource group containing the DNS zone."
  value       = azurerm_dns_zone.main.resource_group_name
}