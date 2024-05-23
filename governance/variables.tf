variable "location" {
  description = "The Azure region to create things in."
  type        = string
}
variable "location_short" {
  description = "The Azure region short name."
  type        = string
}

variable "environment" {
  description = "The envrionment for deployment"
  type        = string
}

variable "azure_ad_group_prefix" {
  description = "Prefix for Entra ID group"
  type        = string

}

variable "resource_group_config" {
  description = "Resource group configuration"
  type = list(
    object({
      common_name         = string
      tags                = map(string)
      lock_resource_group = bool
    })
  )
}
