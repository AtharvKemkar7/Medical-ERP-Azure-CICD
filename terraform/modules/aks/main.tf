resource "azurerm_kubernetes_cluster" "main" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = replace(var.cluster_name, "-", "")

  kubernetes_version = var.kubernetes_version

  private_cluster_enabled = !var.public_endpoint

  oidc_issuer_enabled       = true
  workload_identity_enabled = true
  azure_policy_enabled      = true

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name                 = "system"
    vm_size              = var.node_instance_types[0]
    vnet_subnet_id       = var.private_subnet_ids[0]
    zones                = ["3"]
    type                 = "VirtualMachineScaleSets"
    orchestrator_version = var.kubernetes_version

    auto_scaling_enabled = true
    min_count            = var.node_min_size
    max_count            = var.node_max_size

    node_labels = {
      role = "system"
    }

    tags = var.tags
  }

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    network_policy      = "azure"

    load_balancer_sku = "standard"
    outbound_type     = "loadBalancer"

    service_cidr   = var.service_cidr
    dns_service_ip = var.dns_service_ip
  }

  dynamic "api_server_access_profile" {
    for_each = var.public_endpoint ? [1] : []

    content {
      authorized_ip_ranges = var.public_access_cidrs
    }
  }

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "application" {
  name                  = "app"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.main.id
  vm_size               = var.node_instance_types[0]
  vnet_subnet_id        = var.private_subnet_ids[0]
  mode                  = "User"
  orchestrator_version  = var.kubernetes_version

  auto_scaling_enabled = true
  min_count            = var.node_min_size
  max_count            = var.node_max_size

  zones = ["3"]

  node_labels = {
    role = "application"
  }

  tags = var.tags
}

resource "azurerm_role_assignment" "network_contributor" {
  scope                = var.vpc_id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_kubernetes_cluster.main.identity[0].principal_id
}

resource "azurerm_role_assignment" "acr_pull" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
}