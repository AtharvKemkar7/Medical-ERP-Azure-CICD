terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "med-erp-tfstate-rg"
    storage_account_name = "mederptfstate"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
    use_azuread_auth     = true
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.azure_subscription_id
  tenant_id       = var.azure_tenant_id
}

locals {
  project     = "med-erp"
  environment = "dev"

  common_tags = {
    Project     = local.project
    Environment = local.environment
    ManagedBy   = "Terraform"
    Application = "Medical ERP"
  }
}

resource "azurerm_resource_group" "main" {
  name     = "${local.project}-${local.environment}-rg"
  location = var.azure_location

  tags = local.common_tags
}

module "vnet" {
  source = "../../modules/vnet"

  name                = "${local.project}-${local.environment}-vnet"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  vpc_cidr     = "10.10.0.0/16"
  cluster_name = "${local.project}-${local.environment}-aks"

  tags = local.common_tags
}

module "acr" {
  source = "../../modules/acr"

  project             = local.project
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  sku = "Standard"

  tags = local.common_tags
}

module "aks" {
  source = "../../modules/aks"

  cluster_name        = "${local.project}-${local.environment}-aks"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  kubernetes_version = null

  vpc_id             = module.vnet.vpc_id
  vpc_cidr           = module.vnet.vpc_cidr
  private_subnet_ids = module.vnet.private_subnet_ids

  acr_id = module.acr.registry_id

  node_instance_types = [
    "Standard_D2s_v5"
  ]

  capacity_type     = "ON_DEMAND"
  node_desired_size = 2
  node_min_size     = 1
  node_max_size     = 3

  public_endpoint     = true
  public_access_cidrs = [var.developer_ip_cidr]

  tags = local.common_tags
}

module "azure_dns" {
  source = "../../modules/azure-dns"

  resource_group_name = azurerm_resource_group.main.name
  domain_name         = var.domain_name

  frontend_endpoint  = ""
  ingress_ip_address = var.ingress_ip_address

  tags = local.common_tags
}

output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "vnet_id" {
  value = module.vnet.vpc_id
}

output "aks_cluster_name" {
  value = module.aks.cluster_name
}

output "aks_endpoint" {
  value     = module.aks.cluster_endpoint
  sensitive = true
}

output "acr_name" {
  value = module.acr.registry_name
}

output "acr_login_server" {
  value = module.acr.login_server
}

output "dns_name_servers" {
  value = module.azure_dns.name_servers
}