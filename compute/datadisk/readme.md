Data disk module
============================

## Basic Usage

```HCL
module "sstest_datadisk_mdf" {
  source = "github.com/opsworld2018/terraform-azurerm-module/compute/datadisk"

  resource_group_name         = "${data.azurerm_resource_group.main.name}"
  location                    = "${data.azurerm_resource_group.main.location}"
  enable_data_disk            = true
  enable_data_disk_attachment = true
  datadisk_name_prefix        = "sstest-mdf"
  num_data_disk               = 3
  storage_account_type        = "Premium_LRS"
  disk_size_gb                = "128"
  virtual_machine_id          = "${module.vm_sstest.vm_id}"
  lun_base                    = 0
  caching                     = "ReadWrite"

  tags = {
    Name        = "${var.main_env}-sstest"
    Environment = "${var.main_env}"
    Product     = "${var.main_product}"
  }
}
```