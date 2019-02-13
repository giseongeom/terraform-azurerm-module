resource "random_string" "aks" {
  length      = 4
  special     = false
  upper       = false
  min_numeric = 1
  min_lower   = 1
}

resource "azurerm_kubernetes_cluster" "aks" {
  count = "${var.enable_aks_cluster ? 1 : 0}"
  name  = "${var.aks_cluster_name_prefix}-${random_string.aks.result}"

  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  dns_prefix          = "${var.aks_dns_prefix}"
  kubernetes_version  = "${var.kubernetes_version}"

  linux_profile {
    admin_username = "${var.admin_username}"

    ssh_key {
      key_data = "${var.ssh_key}"
    }
  }

  agent_pool_profile {
    name            = "${var.agent_pool_profile_name}"
    count           = "${var.agent_pool_profile_count}"
    vm_size         = "${var.vm_size}"
    os_type         = "${var.vm_os_type}"
    os_disk_size_gb = "${var.vm_os_disk_size_gb}"
    vnet_subnet_id  = "${var.enable_aks_adv_networking ? var.vnet_subnet_id : ""}"
    max_pods        = "${var.max_pods}"
  }

  service_principal {
    client_id     = "${var.client_id}"
    client_secret = "${var.client_secret}"
  }

  network_profile {
    network_plugin     = "${var.aks_network_plugin}"
    service_cidr       = "${var.aks_network_service_cidr}"
    dns_service_ip     = "${var.aks_network_dns_service_ip}"
    docker_bridge_cidr = "${var.aks_network_docker_bridge_cidr}"
  }

  tags = "${var.tags}"
}
