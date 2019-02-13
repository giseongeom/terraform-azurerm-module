variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created"
}

variable "location" {
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
}

variable "aks_cluster_name_prefix" {
  default = "defaultakscluster"
}

variable "aks_dns_prefix" {
  default = "defaultakscluster"
}

variable "kubernetes_version" {
  default = ""
}

variable "enable_aks_adv_networking" {
  default = false
}

variable "enable_aks_cluster" {
  default = false
}

variable "ssh_key" {
  description = "The public key to be used for ssh access to the VM.  Only used with non-Windows vms and can be left as-is even if using Windows vms. If specifying a path to a certification on a Windows machine to provision a linux vm use the / in the path versus backslash. e.g. c:/home/id_rsa.pub"
}

variable "admin_username" {
  description = "The admin username of the VM that will be deployed"
  default     = "azureuser"
}

variable "agent_pool_profile_count" {
  default = "3"
}

variable "agent_pool_profile_name" {
  default = "defaultagentpool"
}

variable "vm_size" {
  default = "Standard_D1_v2"
}

variable "vm_os_type" {
  default = "Linux"
}

variable "vm_os_disk_size_gb" {
  description = "Storage os disk size size"
  default     = ""
}

variable "vnet_subnet_id" {
  description = "The subnet id of the virtual network where the virtual machines will reside."
}

variable "max_pods" {
  default = 30
}

variable "client_id" {
  default = ""
}

variable "client_secret" {
  default = ""
}

variable "aks_network_plugin" {
  default = "kubenet"
}

variable "aks_network_service_cidr" {
  default = "10.0.0.0/16"
}

variable "aks_network_dns_service_ip" {
  default = "10.0.0.10"
}

variable "aks_network_docker_bridge_cidr" {
  default = "172.17.0.1/16"
}

variable "tags" {
  type        = "map"
  description = "A map of the tags to use on the resources that are deployed with this module."
}
