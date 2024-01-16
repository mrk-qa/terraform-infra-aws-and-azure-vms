# Terraform infra AWS and Azure Virtual Machines ☁️🖥️

## 📑 Project Structure

*Before:*
*The network structure is previously configured.*
```
Resources created:
aws/
   |-- aws_instance
   |-- aws_key_pair
   
azure/
   |-- azurerm_resource_group
   |   |-- azurerm_network_interface
   |   |   |-- azurerm_public_ip
   |   |   |-- azurerm_network_interface_security_group_association
   |   |-- azurerm_linux_virtual_machine
```

## 📑 Test Project Structure

```
tests/
   |-- modules/
   |   |-- http/
   |   |-- random/
   |-- *unit_test_aws.tftest.hcl
   |-- *unit_test_azure.tftest.hcl
   |-- *integration_test_aws.tftest.hcl
   |-- *integration_test_azure.tftest.hcl
```

## 🎯 Results

<p align="center">View result in browser about VM in AWS with IP public access</p>

<div align="center"><img width="600px"  src="https://github.com/mrk-qa/terraform-infra-aws-and-azure-vms/blob/92be9f641492d7768e65e3398251cbe1c9f794c2/assets/view_vm_aws.png">
</div>

<p align="center">View result in browser about VM in Azure with public IP access</p>

<div align="center"><img width="600px"  src="https://github.com/mrk-qa/terraform-infra-aws-and-azure-vms/blob/92be9f641492d7768e65e3398251cbe1c9f794c2/assets/view_vm_azure.png">
</div>

## 🔮 Support this project  

If you want to support this project, leave a ⭐.  

---  

Made with 💙 &nbsp;by Marco Antonio 👋 &nbsp; [Meu LinkedIn](https://www.linkedin.com/in/mrk-silva/)  