resource "azurerm_virtual_network" "vnet" {
  name                = "${var.vnet_name_prefix}-${random_string.vnet.result}-vnet"
  location            = "${var.location}"
  address_space       = ["${var.address_space}"]
  resource_group_name = "${var.resource_group_name}"
  dns_servers         = "${var.dns_servers}"
  tags                = "${var.tags}"

  lifecycle {
    prevent_destroy = true
  }
}

resource "random_string" "vnet" {
  length      = 6
  special     = false
  upper       = false
  min_numeric = 1
  min_lower   = 1
}
