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

<p align="center">View result VM in AWS with IP public access</p>

<div align="center"><img width="600px"  src="https://github.com/mrk-qa/terraform-infra-aws-and-azure-vms/assets/102618854/36c8468a-37c8-485a-93a7-60068f9537a4">
</div>

<p align="center">View result VM in Azure with IP public access</p>

<div align="center"><img width="600px"  src="https://github.com/mrk-qa/terraform-infra-aws-and-azure-vms/assets/102618854/5b67924c-d544-42b8-add9-0e58b9df1ed2">
</div>