variable "domain_name" {
  description = "Primary DNS zone name."
  type        = string
}

variable "domain_names" {
  description = "Additional domain names."
  type        = list(string)
  default     = []
}

variable "resource_group_name" {
  description = "Azure resource group name."
  type        = string
}

variable "frontend_endpoint" {
  description = "Azure CDN frontend endpoint."
  type        = string
  default     = ""
}

variable "ingress_ip_address" {
  description = "Public IP address of the Kubernetes ingress."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Common Azure resource tags."
  type        = map(string)
  default     = {}
}