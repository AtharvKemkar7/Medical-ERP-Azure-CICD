output "frontend_endpoint" {
  description = "Azure CDN endpoint hostname used by the frontend."
  value       = azurerm_cdn_endpoint.frontend.fqdn
}

output "cdn_endpoint_id" {
  description = "Azure CDN endpoint resource ID."
  value       = azurerm_cdn_endpoint.frontend.id
}

output "cdn_profile_id" {
  description = "Azure CDN profile resource ID."
  value       = azurerm_cdn_profile.frontend.id
}

output "storage_account_name" {
  description = "Frontend Azure Storage Account name."
  value       = azurerm_storage_account.frontend.name
}

output "storage_account_id" {
  description = "Frontend Azure Storage Account resource ID."
  value       = azurerm_storage_account.frontend.id
}

output "storage_primary_web_endpoint" {
  description = "Azure Storage static website endpoint."
  value       = azurerm_storage_account.frontend.primary_web_endpoint
}

output "storage_primary_web_host" {
  description = "Azure Storage static website hostname."
  value       = azurerm_storage_account.frontend.primary_web_host
}