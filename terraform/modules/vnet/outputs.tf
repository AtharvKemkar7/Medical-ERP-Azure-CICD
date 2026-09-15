output "vpc_id" {
  description = "Azure Virtual Network resource ID."
  value       = azurerm_virtual_network.main.id
}

output "vnet_id" {
  description = "Azure Virtual Network resource ID."
  value       = azurerm_virtual_network.main.id
}

output "vnet_name" {
  description = "Azure Virtual Network name."
  value       = azurerm_virtual_network.main.name
}

output "public_subnet_ids" {
  description = "IDs of the public subnets."
  value       = azurerm_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets."
  value       = azurerm_subnet.private[*].id
}

output "data_subnet_ids" {
  description = "IDs of the data subnets."
  value       = azurerm_subnet.data[*].id
}

output "vpc_cidr" {
  description = "Virtual Network CIDR range."
  value       = var.vpc_cidr
}

output "nat_gateway_id" {
  description = "NAT Gateway resource ID."
  value       = azurerm_nat_gateway.main.id
}

output "nat_public_ip" {
  description = "Public IP address used by the NAT Gateway."
  value       = azurerm_public_ip.nat.ip_address
}