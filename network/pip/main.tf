resource "random_string" "pip" {
  length      = 6
  special     = false
  upper       = false
  min_numeric = 1
  min_lower   = 1
}

resource "azurerm_public_ip" "pip" {
  count                        = "${var.enabled ? 1 : 0}"
  name                         = "pip-${var.pip_name_prefix}-${random_string.pip.result}"
  location                     = "${var.location}"
  resource_group_name          = "${var.resource_group_name}"
  public_ip_address_allocation = "${var.public_ip_address_allocation}"
  domain_name_label            = "${var.domain_name_label_prefix}-${random_string.pip.result}"
  sku                          = "${var.sku}"
  idle_timeout_in_minutes      = "${var.idle_timeout_in_minutes}"

  tags = "${var.tags}"
}
