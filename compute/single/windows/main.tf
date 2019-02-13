resource "random_string" "nic" {
  length      = 8
  special     = false
  upper       = false
  min_numeric = 1
  min_lower   = 1
}

resource "random_string" "extension" {
  length      = 8
  special     = false
  upper       = false
  min_numeric = 1
  min_lower   = 1
}

resource "random_string" "vm" {
  length      = 4
  special     = false
  min_numeric = 1
  min_lower   = 1
  min_upper   = 1
}

resource "random_string" "osdisk" {
  length  = 32
  special = false
  upper   = false
}

resource "azurerm_virtual_machine" "vm" {
  count                         = "${var.enabled ? 1 : 0}"
  name                          = "${var.vm_hostname}-${random_string.vm.result}"
  location                      = "${var.location}"
  resource_group_name           = "${var.resource_group_name}"
  vm_size                       = "${var.vm_size}"
  network_interface_ids         = ["${element(azurerm_network_interface.vm.*.id, count.index)}"]
  delete_os_disk_on_termination = "${var.delete_os_disk_on_termination}"

  storage_image_reference {
    id        = "${var.vm_os_id}"
    publisher = "${var.vm_os_publisher}"
    offer     = "${var.vm_os_offer}"
    sku       = "${var.vm_os_sku}"
    version   = "${var.vm_os_version}"
  }

  storage_os_disk {
    name              = "${var.vm_hostname}-${random_string.vm.result}-${count.index}_OsDisk_${element(random_string.osdisk.*.result, count.index)}"
    create_option     = "FromImage"
    caching           = "ReadWrite"
    managed_disk_type = "${var.vm_os_disk_managed_disk_type}"
    disk_size_gb      = "${var.vm_os_disk_size_gb}"
  }

  os_profile {
    computer_name  = "${var.vm_hostname}-${random_string.vm.result}"
    admin_username = "${var.admin_username}"
    admin_password = "${var.admin_password}"
    custom_data    = "${var.vm_custom_data}"
  }

  os_profile_windows_config {
    provision_vm_agent        = "${var.os_profile_windows_provision_vm_agent}"
    enable_automatic_upgrades = "${var.os_profile_windows_automatic_upgrades}"
  }

  tags = "${var.tags}"
}

resource "azurerm_network_interface" "vm" {
  count                     = "${var.enabled ? 1 : 0}"
  name                      = "nic-${var.vm_hostname}-${random_string.nic.result}-${count.index}"
  location                  = "${var.location}"
  resource_group_name       = "${var.resource_group_name}"
  network_security_group_id = "${var.nsg_id}"

  ip_configuration {
    name                          = "ipconfig${count.index}"
    subnet_id                     = "${var.vnet_subnet_id}"
    private_ip_address_allocation = "${var.enable_static_private_ip ? "Static" : "Dynamic"}"
    private_ip_address            = "${var.enable_static_private_ip ? element(concat(var.static_private_ip_address_list, list("")), count.index) : ""}"
    public_ip_address_id          = "${var.enable_public_ip ? element(concat(var.vm_public_ip_id, list("")), count.index) : ""}"
  }
}

resource "azurerm_virtual_machine_extension" "vm" {
  count                = "${var.enable_vm_extension ? 1 : 0}"
  name                 = "extension-${var.vm_hostname}-${random_string.extension.result}-${count.index}"
  location             = "${var.location}"
  resource_group_name  = "${var.resource_group_name}"
  virtual_machine_name = "${element(azurerm_virtual_machine.vm.*.name, count.index)}"
  publisher            = "${var.extension_publisher}"
  type                 = "${var.extension_type}"
  type_handler_version = "${var.extension_type_handler_version}"
  settings             = "${var.extension_settings}"
  protected_settings   = "${var.extension_protected_settings}"

  tags = "${var.tags}"
}
