output "vm_id" {
  description = "Virtual machine ids created."
  value       = "${length(azurerm_virtual_machine.vm.*.id) > 0 ? element(concat(azurerm_virtual_machine.vm.*.id, list("")), 0) : ""}"
}

output "network_interface_id" {
  description = "ids of the vm nics provisoned."
  value       = "${length(azurerm_network_interface.vm.*.id) > 0 ? element(concat(azurerm_network_interface.vm.*.id, list("")), 0) : ""}"
}

output "network_interface_private_ip" {
  description = "private ip addresses of the vm nics"
  value       = "${length(azurerm_network_interface.vm.*.private_ip_address) > 0 ? element(concat(azurerm_network_interface.vm.*.private_ip_address, list("")), 0) : ""}"
}
