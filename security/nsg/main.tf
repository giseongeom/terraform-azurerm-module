resource "azurerm_network_security_group" "nsg" {
  name                = "${var.security_group_name_prefix}-${random_string.nsg.result}-nsg"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  tags                = "${var.tags}"
}

resource "azurerm_network_security_rule" "custom_rules" {
  count                       = "${length(var.custom_rules)}"
  name                        = "${lookup(var.custom_rules[count.index], "name", "default_rule_name")}-${substr(md5(lookup(var.custom_rules[count.index], "name", "random")), 0, 3)}-${substr(md5(var.resource_group_name), 0, 3)}"
  priority                    = "${var.nsg_rule_base_priority + (10 * count.index)}"
  direction                   = "${lookup(var.custom_rules[count.index], "direction", "Any")}"
  access                      = "${lookup(var.custom_rules[count.index], "access", "Allow")}"
  protocol                    = "${lookup(var.custom_rules[count.index], "protocol", "*")}"
  source_port_range           = "*"
  destination_port_ranges     = "${split(",", replace(  "${lookup(var.custom_rules[count.index], "destination_port_ranges", "*" )}"  ,  "*" , "0-65535" ) )}"
  source_address_prefix       = "${lookup(var.custom_rules[count.index], "source_address_prefix", "*")}"
  destination_address_prefix  = "${lookup(var.custom_rules[count.index], "destination_address_prefix", "*")}"
  description                 = "${lookup(var.custom_rules[count.index], "description", "Security rule for ${lookup(var.custom_rules[count.index], "name", "default_rule_name")}")}"
  resource_group_name         = "${var.resource_group_name}"
  network_security_group_name = "${azurerm_network_security_group.nsg.name}"
}

resource "random_string" "nsg" {
  length      = 6
  special     = false
  upper       = false
  min_numeric = 1
  min_lower   = 1
}
