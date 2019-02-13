
output "id" {
  description = "The ids of subnets created inside the newl vNet"
  value       = "${azurerm_subnet.subnet.id}"
}
