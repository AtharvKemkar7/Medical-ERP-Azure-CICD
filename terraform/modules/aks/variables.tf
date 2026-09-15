variable "cluster_name" {
  description = "AKS cluster name."
  type        = string
}

variable "resource_group_name" {
  description = "Azure Resource Group name."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "kubernetes_version" {
  description = "AKS Kubernetes version. Null uses the default supported version."
  type        = string
  default     = null
}

variable "vpc_id" {
  description = "Azure Virtual Network resource ID."
  type        = string
}

variable "vpc_cidr" {
  description = "Virtual Network CIDR range."
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs used by AKS nodes."
  type        = list(string)
}

variable "acr_id" {
  description = "Azure Container Registry resource ID."
  type        = string
}

variable "node_instance_types" {
  description = "Azure VM sizes for AKS node pools."
  type        = list(string)

  default = [
    "Standard_D2s_v5"
  ]

  validation {
    condition     = length(var.node_instance_types) > 0
    error_message = "At least one node instance type must be provided."
  }
}

variable "capacity_type" {
  description = "Compatibility field for the original AWS configuration."
  type        = string
  default     = "ON_DEMAND"

  validation {
    condition     = contains(["ON_DEMAND", "SPOT"], var.capacity_type)
    error_message = "capacity_type must be ON_DEMAND or SPOT."
  }
}

variable "node_desired_size" {
  description = "Desired number of nodes. AKS autoscaling starts within the min/max range."
  type        = number
  default     = 2
}

variable "node_min_size" {
  description = "Minimum number of nodes."
  type        = number
  default     = 1
}

variable "node_max_size" {
  description = "Maximum number of nodes."
  type        = number
  default     = 3
}

variable "public_endpoint" {
  description = "Whether the AKS API server has a public endpoint."
  type        = bool
  default     = true
}

variable "public_access_cidrs" {
  description = "Authorized public IP ranges for the AKS API server."
  type        = list(string)
  default     = []
}

variable "service_cidr" {
  description = "Kubernetes service CIDR."
  type        = string
  default     = "10.100.0.0/16"
}

variable "dns_service_ip" {
  description = "Kubernetes DNS service IP."
  type        = string
  default     = "10.100.0.10"
}

variable "tags" {
  description = "Tags applied to Azure resources."
  type        = map(string)
  default     = {}
}