variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created"
}

variable "location" {
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
}

variable "pip_name_prefix" {
  default = "pip"
}

variable "domain_name_label_prefix" {
  description = "Optional globally unique per datacenter region domain name label to apply to each public ip address. e.g. thisvar.varlocation.cloudapp.azure.com where you specify only thisvar here. This is an array of names which will pair up sequentially to the number of public ips defined in var.nb_public_ip. One name or empty string is required for every public ip. If no public ip is desired, then set this to an array with a single empty string."
  default     = "myvm"
}

variable "public_ip_address_allocation" {
  description = "Defines how an IP address is assigned. Options are Static or Dynamic."
  default     = "dynamic"
}

variable "tags" {
  type        = "map"
  description = "A map of the tags to use on the resources that are deployed with this module."
}

variable "enabled" {
  default = true
}

variable "sku" {
  default = "Basic"
}

variable "idle_timeout_in_minutes" {
  default = 5
}
