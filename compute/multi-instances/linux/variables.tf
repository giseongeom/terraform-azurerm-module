variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created"
}

variable "location" {
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
}

variable "nsg_id" {}

variable "vnet_subnet_id" {
  description = "The subnet id of the virtual network where the virtual machines will reside."
}

variable "enable_static_private_ip" {
  default = false
}

variable "static_private_ip_address_list" {
  type    = "list"
  default = []
}

variable "enable_public_ip" {
  default = false
}

variable "pip_domain_name_label" {
  description = "Optional globally unique per datacenter region domain name label to apply to each public ip address. e.g. thisvar.varlocation.cloudapp.azure.com where you specify only thisvar here. This is an array of names which will pair up sequentially to the number of public ips defined in var.nb_public_ip. One name or empty string is required for every public ip. If no public ip is desired, then set this to an array with a single empty string."
  default     = "myvm"
}

variable "ssh_key" {
  description = "The public key to be used for ssh access to the VM.  Only used with non-Windows vms and can be left as-is even if using Windows vms. If specifying a path to a certification on a Windows machine to provision a linux vm use the / in the path versus backslash. e.g. c:/home/id_rsa.pub"
}

variable "admin_username" {
  description = "The admin username of the VM that will be deployed"
  default     = "azureuser"
}

variable "admin_password" {
  description = "The admin password to be used on the VMSS that will be deployed. The password must meet the complexity requirements of Azure"
  default     = ""
}

variable "vm_custom_data" {
  default = ""
}

variable "storage_account_type" {
  description = "Defines the type of storage account to be created. Valid options are Standard_LRS, Standard_ZRS, Standard_GRS, Standard_RAGRS, Premium_LRS."
  default     = "Premium_LRS"
}

variable "vm_size" {
  description = "Specifies the size of the virtual machine."
  default     = "Standard_DS2_V2"
}

variable "num_of_instances" {
  description = "Specify the number of vm instances"
  default     = "1"
}

variable "vm_hostname" {
  description = "local name of the VM"
  default     = "myvm"
}

variable "vm_os_id" {
  description = "The ID of the image that you want to deploy if you are using a custom image."
  default     = ""
}

variable "vm_os_publisher" {
  description = "The name of the publisher of the image that you want to deploy"
  default     = "Canonical"
}

variable "vm_os_offer" {
  description = "The name of the offer of the image that you want to deploy"
  default     = "UbuntuServer"
}

variable "vm_os_sku" {
  description = "The sku of the image that you want to deploy"
  default     = "18.04-LTS"
}

variable "vm_os_version" {
  description = "The version of the image that you want to deploy."
  default     = "latest"
}

variable "public_ip_address_allocation" {
  description = "Defines how an IP address is assigned. Options are Static or Dynamic."
  default     = "dynamic"
}

variable "nb_public_ip" {
  description = "Number of public IPs to assign corresponding to one IP per vm. Set to 0 to not assign any public IP addresses."
  default     = "1"
}

variable "delete_os_disk_on_termination" {
  description = "Delete datadisk when machine is terminated"
  default     = "true"
}

variable "vm_os_disk_size_gb" {
  description = "Storage os disk size size"
  default     = ""
}

variable "vm_os_disk_managed_disk_type" {
  description = "Defines the type of managed disk to be created. Valid options are Standard_LRS, Premium_LRS."
  default     = "Standard_LRS"
}

variable "boot_diagnostics" {
  description = "(Optional) Enable or Disable boot diagnostics"
  default     = "false"
}

variable "boot_diagnostics_sa_type" {
  description = "(Optional) Storage account type for boot diagnostics"
  default     = "Standard_LRS"
}

variable "tags" {
  type        = "map"
  description = "A map of the tags to use on the resources that are deployed with this module."
}

variable "enable_vm_extension" {
  default = false
}

variable "extension_publisher" {
  #default = "Microsoft.Azure.Extensions"
  default = ""
}

variable "extension_type" {
  default = ""
}

variable "extension_type_handler_version" {
  default = ""
}

variable "extension_settings" {
  default = ""
}

variable "extension_protected_settings" {
  default = ""
}
