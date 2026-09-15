variable "azure_subscription_id" {
  description = "Azure subscription ID."
  type        = string
  sensitive   = true
}

variable "azure_tenant_id" {
  description = "Azure tenant ID."
  type        = string
  sensitive   = true
}

variable "azure_location" {
  description = "Azure region."
  type        = string
  default     = "Central India"
}

variable "domain_name" {
  description = "Root domain name, for example example.com."
  type        = string
}

variable "domain_names" {
  description = "Frontend custom domain names."
  type        = list(string)
  default     = []
}

variable "azure_certificate_id" {
  description = "Optional Azure certificate resource ID."
  type        = string
  default     = null
}

variable "developer_ip_cidr" {
  description = "Developer public IP address in CIDR notation."
  type        = string
}

variable "ingress_ip_address" {
  description = "Public IP address of the Kubernetes ingress."
  type        = string
  default     = ""
}