resource "azurerm_subnet" "subnet" {
  name                      = "${var.name}"
  virtual_network_name      = "${var.virtual_network_name}"
  resource_group_name       = "${var.resource_group_name}"
  address_prefix            = "${var.address_prefix}"
  service_endpoints         = "${var.service_endpoints}"
  network_security_group_id = "${var.network_security_group_id}"
  route_table_id            = "${var.route_table_id}"
}

resource "azurerm_subnet_network_security_group_association" "subnet" {
  count                     = "${length(var.network_security_group_id) > 0 ? 1 : 0 }"
  subnet_id                 = "${azurerm_subnet.subnet.id}"
  network_security_group_id = "${var.network_security_group_id}"
}

resource "azurerm_subnet_route_table_association" "sbunet" {
  count          = "${length(var.route_table_id) > 0 ? 1 : 0}"
  subnet_id      = "${azurerm_subnet.subnet.id}"
  route_table_id = "${var.route_table_id}"
}
