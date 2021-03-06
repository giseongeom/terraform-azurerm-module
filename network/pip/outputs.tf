output "public_ip_id" {
  description = "id of the public ip address provisoned."
  value       = "${azurerm_public_ip.pip.*.id}"
}

output "public_ip_address" {
  description = "The actual ip address allocated for the resource."
  value       = "${azurerm_public_ip.pip.*.ip_address}"
}

output "public_ip_dns_name" {
  description = "fqdn to connect to the first vm provisioned."
  value       = "${azurerm_public_ip.pip.*.fqdn}"
}
