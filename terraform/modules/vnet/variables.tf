variable "name" {
  description = "Name of the Azure Virtual Network."
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

variable "vpc_cidr" {
  description = "Address range for the Virtual Network."
  type        = string
}

variable "cluster_name" {
  description = "AKS cluster name used for compatibility and resource naming."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags applied to Azure resources."
  type        = map(string)
  default     = {}
}