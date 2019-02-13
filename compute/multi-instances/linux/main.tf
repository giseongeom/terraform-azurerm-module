resource "random_string" "pip" {
  length      = 6
  special     = false
  upper       = false
  min_numeric = 1
  min_lower   = 1
}

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
  length      = 6
  special     = false
  min_numeric = 1
  min_lower   = 2
  min_upper   = 1
}

resource "random_string" "avset" {
  length      = 8
  special     = false
  upper       = false
  min_numeric = 1
  min_lower   = 1
}

resource "random_string" "osdisk" {
  count   = "${var.num_of_instances}"
  length  = 32
  special = false
  upper   = false
}

resource "azurerm_virtual_machine" "vm" {
  count                         = "${var.num_of_instances}"
  name                          = "${var.vm_hostname}-${random_string.vm.result}-${count.index}"
  location                      = "${var.location}"
  resource_group_name           = "${var.resource_group_name}"
  availability_set_id           = "${azurerm_availability_set.vm.id}"
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
    computer_name  = "${var.vm_hostname}-${random_string.vm.result}-${count.index}"
    admin_username = "${var.admin_username}"
    admin_password = "${var.admin_password}"
    custom_data    = "${var.vm_custom_data}"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.admin_username}/.ssh/authorized_keys"
      key_data = "${var.ssh_key}"
    }
  }

  tags = "${var.tags}"
}

resource "azurerm_availability_set" "vm" {
  name                = "avset-${var.vm_hostname}-${random_string.avset.result}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  managed             = true

  tags = "${var.tags}"
}

resource "azurerm_public_ip" "vm" {
  count                        = "${var.enable_public_ip ? var.num_of_instances : 0}"
  name                         = "pip-${var.vm_hostname}-${random_string.pip.result}-${count.index}"
  location                     = "${var.location}"
  resource_group_name          = "${var.resource_group_name}"
  public_ip_address_allocation = "${var.public_ip_address_allocation}"
  domain_name_label            = "${var.pip_domain_name_label}-${random_string.pip.result}-${count.index}"
}

resource "azurerm_network_interface" "vm" {
  count                     = "${var.num_of_instances}"
  name                      = "nic-${var.vm_hostname}-${random_string.nic.result}-${count.index}"
  location                  = "${var.location}"
  resource_group_name       = "${var.resource_group_name}"
  network_security_group_id = "${var.nsg_id}"

  ip_configuration {
    name                          = "ipconfig${count.index}"
    subnet_id                     = "${var.vnet_subnet_id}"
    private_ip_address_allocation = "${var.enable_static_private_ip ? "Static" : "Dynamic"}"
    private_ip_address            = "${var.enable_static_private_ip ? element(concat(var.static_private_ip_address_list, list("")), count.index) : ""}"
    public_ip_address_id          = "${length(azurerm_public_ip.vm.*.id) > 0 ? element(concat(azurerm_public_ip.vm.*.id, list("")), count.index) : ""}"
  }
}

resource "azurerm_virtual_machine_extension" "vm" {
  count                = "${var.enable_vm_extension ? var.num_of_instances : 0}"
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
