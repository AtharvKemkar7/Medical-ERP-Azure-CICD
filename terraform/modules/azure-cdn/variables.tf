variable "project" {
  description = "Project name used for naming resources."
  type        = string
}

variable "environment" {
  description = "Deployment environment, such as dev or prod."
  type        = string
}

variable "resource_group_name" {
  description = "Azure Resource Group name."
  type        = string
}

variable "location" {
  description = "Azure region where frontend resources will be created."
  type        = string
}

variable "domain_names" {
  description = "Custom frontend domain names."
  type        = list(string)
  default     = []
}

variable "certificate_id" {
  description = "Optional Azure certificate resource ID reserved for custom-domain TLS configuration."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags applied to Azure resources."
  type        = map(string)
  default     = {}
}