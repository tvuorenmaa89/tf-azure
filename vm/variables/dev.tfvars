environment       = "dev"
location          = "swedencentral"
location_short    = "sc"
environment_short = "d"
vm_config = {
  count    = 3
  username = "localadmin"
  size     = "Standard_D8s_v5"
  source_image_reference = {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "83-gen2"
    version   = "latest"
  }
  storage_os_disk = {
    caching              = "ReadWrite"
    create_option        = "FromImage"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = "128"
  }
}
