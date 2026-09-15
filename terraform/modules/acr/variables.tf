variable "project" {
  description = "Project name used for naming Azure resources."
  type        = string
}

variable "resource_group_name" {
  description = "Azure Resource Group name."
  type        = string
}

variable "location" {
  description = "Azure region where the ACR will be created."
  type        = string
}

variable "sku" {
  description = "Azure Container Registry SKU."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "The ACR SKU must be Basic, Standard, or Premium."
  }
}

variable "tags" {
  description = "Tags applied to Azure resources."
  type        = map(string)
  default     = {}
}