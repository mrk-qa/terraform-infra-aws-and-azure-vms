# Terraform infra AWS and Azure Virtual Machines ☁️🖥️


*Before:*
*The network structure is previously configured.*
```
Resources created:
aws
   |-- aws_instance
   |-- aws_key_pair
   
azure
   |-- azurerm_resource_group
   |   |-- azurerm_network_interface
   |   |   |-- azurerm_public_ip
   |   |   |-- azurerm_network_interface_security_group_association
   |   |-- azurerm_linux_virtual_machine
```

<p align="center">View result in browser about VM in AWS with IP public access</p>

<div align="center"><img width="600px"  src="https://github.com/mrk-qa/terraform-infra-aws-and-azure-vms/assets/102618854/95289b7c-b279-4d1c-bfbc-167e63db7014">
</div>

<p align="center">View result in browser about VM in Azure with public IP access</p>

<div align="center"><img width="600px"  src="https://github.com/mrk-qa/terraform-infra-aws-and-azure-vms/assets/102618854/6f53585e-c8e1-4371-be1d-92ff856b0a5a">
</div>