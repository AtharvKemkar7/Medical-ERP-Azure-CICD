output "cluster_name" {
  description = "AKS cluster name."
  value       = azurerm_kubernetes_cluster.main.name
}

output "cluster_id" {
  description = "AKS cluster resource ID."
  value       = azurerm_kubernetes_cluster.main.id
}

output "cluster_endpoint" {
  description = "AKS Kubernetes API server endpoint."
  value       = azurerm_kubernetes_cluster.main.kube_config[0].host
}

output "cluster_ca_certificate" {
  description = "AKS cluster CA certificate."
  value       = azurerm_kubernetes_cluster.main.kube_config[0].cluster_ca_certificate
  sensitive   = true
}

output "oidc_issuer_url" {
  description = "AKS OIDC issuer URL."
  value       = azurerm_kubernetes_cluster.main.oidc_issuer_url
}

output "kubelet_identity_object_id" {
  description = "Kubelet identity object ID used for ACR pull permissions."
  value       = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
}

output "kubelet_identity_client_id" {
  description = "Kubelet identity client ID."
  value       = azurerm_kubernetes_cluster.main.kubelet_identity[0].client_id
}

output "node_group_role_arn" {
  description = "Compatibility output containing the AKS kubelet identity object ID."
  value       = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
}

output "kube_config_raw" {
  description = "Raw AKS kubeconfig."
  value       = azurerm_kubernetes_cluster.main.kube_config_raw
  sensitive   = true
}