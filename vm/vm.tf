locals {
  vm_base_name      = "${var.environment_short}-${var.location_short}-${var.common_name_short}"
  vm_base_host_name = "${var.environment_short}-${var.location_short}-${var.common_name_short}"
}

resource "random_password" "vm_password" {
  count   = var.vm_config.count
  length  = 16
  special = true

  keepers = {
    vmPassword = "${local.vm_base_name}-${format("%02s", count.index + 1)}"
  }
}

# TLS for ssh key
resource "tls_private_key" "virtual_machine_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

#Save Key as a secret on KV
resource "azurerm_key_vault_secret" "virtual_machine_private_ssh_key" {
  name         = "virtual-machine-private-ssh-key"
  value        = tls_private_key.virtual_machine_ssh_key.private_key_openssh
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_network_interface" "nic_1" {
  count               = var.vm_config.count
  name                = "nic-${local.vm_base_name}-${var.core_config.subnet_name_1}-${format("%02s", count.index + 1)}-01"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig-01"
    subnet_id                     = data.azurerm_subnet.subnet_1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "nic_2" {
  count               = var.vm_config.count
  name                = "nic-${local.vm_base_name}-${var.core_config.subnet_name_2}-${format("%02s", count.index + 1)}-01"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig-01"
    subnet_id                     = data.azurerm_subnet.subnet_2.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "nic_3" {
  count               = var.vm_config.count
  name                = "nic-${local.vm_base_name}-${var.core_config.subnet_name_3}-${format("%02s", count.index + 1)}-01"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig-01"
    subnet_id                     = data.azurerm_subnet.subnet_3.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  count               = var.vm_config.count
  name                = "${local.vm_base_name}-${format("%02s", count.index + 1)}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  size                = var.vm_config.size
  admin_username      = var.vm_config.username

  network_interface_ids = [
    azurerm_network_interface.nic_1[count.index].id,
    azurerm_network_interface.nic_2[count.index].id,
    azurerm_network_interface.nic_3[count.index].id
  ]

  zone = ((count.index % var.location_zone_count) + 1)

  admin_ssh_key {
    username   = var.vm_config.username
    public_key = tls_private_key.virtual_machine_ssh_key.public_key_openssh
  }

  source_image_reference {
    publisher = var.vm_config.source_image_reference.publisher
    offer     = var.vm_config.source_image_reference.offer
    sku       = var.vm_config.source_image_reference.sku
    version   = var.vm_config.source_image_reference.version
  }

  os_disk {
    name                 = "osdisk-${local.vm_base_name}-${format("%02s", count.index + 1)}"
    caching              = var.vm_config.storage_os_disk.caching
    storage_account_type = var.vm_config.storage_os_disk.storage_account_type

  }
}
