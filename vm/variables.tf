variable "location" {
  description = "The Azure region to create things in."
  type        = string
}

variable "environment" {
  description = "The environment of the Azure resource, prod, test, uat."
  type        = string
}

variable "environment_short" {
  description = "The environment of the Azure resource, p = prod, t = test u = uat."
  type        = string
}

variable "location_short" {
  description = "The Azure region short name."
  type        = string
}

variable "location_zone_count" {
  description = "Number of zones in Azure region."
  type        = number
}

variable "common_name" {
  description = "The commonName to use for the deploy"
  type        = string
}

variable "common_name_short" {
  description = "Short commonName to use as VM hostname"
  type        = string
}

variable "core_config" {
  description = "The configuration of the core infra"
  type = object({
    common_name   = string
    subnet_name_1 = string
    subnet_name_2 = string
    subnet_name_3 = string
  })
}

variable "vm_config" {
  description = "Configuration of the virtual machines"
  type = object({
    count    = number
    username = string
    size     = string
    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
    storage_os_disk = object({
      caching              = string
      disk_size_gb         = string
      storage_account_type = string
    })
  })
}

variable "key_vault_name" {
  description = "Name of the keyVault"
  default     = "testkeyVault123"
}

variable "encryption_key_url" {
  description = "URL to encrypt Key"
  default     = ""
}

variable "encryption_algorithm" {
  description = " Algo for encryption"
  default     = "RSA-OAEP"
}

variable "volume_type" {
  default = "All"
}

variable "encrypt_operation" {
  default = "EnableEncryption"
}

variable "type_handler_version" {
  description = "Type handler version of the VM extension to use. Defaults to 2.2 on Windows and 1.1 on Linux"
  default     = ""
}

variable "vm_name" {
  description = "Name of the VM to encrypt"
  default     = "ubuntu1"
}

variable "vm_os_type" {
  description = "Type of OS. Allowed values are Windows and Linux. Defaults to Linux"
  default     = "linux"
}

variable "unique_suffix" {
  description = "Customer unique suffix."
  type        = string
}
