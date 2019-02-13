output "cluster_name" {
  value = "${azurerm_kubernetes_cluster.aks.*.name}"
}

output "cluster_fqdn" {
  value = "${azurerm_kubernetes_cluster.aks.*.fqdn}"
}

output "cluster_id" {
  value = "${azurerm_kubernetes_cluster.aks.*.id}"
}

output "cluster_resource_group" {
  value = "${azurerm_kubernetes_cluster.aks.*.node_resource_group}"
}
