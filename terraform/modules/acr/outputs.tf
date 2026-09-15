output "registry_id" {
  description = "Azure Container Registry resource ID."
  value       = azurerm_container_registry.main.id
}

output "registry_name" {
  description = "Azure Container Registry name."
  value       = azurerm_container_registry.main.name
}

output "login_server" {
  description = "Azure Container Registry login server."
  value       = azurerm_container_registry.main.login_server
}

output "admin_enabled" {
  description = "Whether the ACR admin account is enabled."
  value       = azurerm_container_registry.main.admin_enabled
}