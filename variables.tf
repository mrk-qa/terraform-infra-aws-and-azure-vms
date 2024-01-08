variable "aws_key_pub" {
  description = "Chave pública para a vm na AWS"
  type        = string
}

variable "azure_key_pub" {
  description = "Chave pública para a vm na Azure"
  type        = string
}

variable "location_azure" {
  description = "Região onde os recursos serão criados"
  type        = string
  default     = "East US"
}

variable "location_aws" {
  description = "Região onde os recursos serão criados"
  type        = string
  default     = "us-east-1"
}

variable "key_pair_name_aws" {
  description = "Nome da key pair usada na AWS"
  type        = string
  default     = "aws-key-github"
}

variable "ami_aws" {
  description = "AMI utilizada na AWS"
  type        = string
  default     = "ami-0c7217cdde317cfec"
}

variable "instance_type_aws" {
  description = "Tipo de instância utilizada na AWS"
  type        = string
  default     = "t2.micro"
}

variable "rg_name_azure" {
  description = "Nome do resource group usado na Azure"
  type        = string
  default     = "rg-vm-tf-github"
}

variable "public_ip_name_azure" {
  description = "Nome do public ip usado na Azure"
  type        = string
  default     = "public-ip-terraform-github"
}

variable "network_interface_name_azure" {
  description = "Nome do network interface usado na Azure"
  type        = string
  default     = "nic-tf-github"
}

variable "ip_configuration_name_azure" {
  description = "Nome do ip configuration usado na Azure"
  type        = string
  default     = "public-ip-terraform-github"
}

variable "vm_name_azure" {
  description = "Nome da VM usado na Azure"
  type        = string
  default     = "vm-terraform-github"
}

variable "vm_size_azure" {
  description = "Tamanho da VM usado na Azure"
  type        = string
  default     = "Standard_B1s"
}

variable "vm_admin_username_azure" {
  description = "Usuário admin da VM usado na Azure"
  type        = string
  default     = "terraform"
}

variable "vm_os_disk_caching_azure" {
  description = "Disk caching da VM usado na Azure"
  type        = string
  default     = "ReadWrite"
}

variable "vm_os_disk_storage_azure" {
  description = "Disk storage da VM usado na Azure"
  type        = string
  default     = "Standard_LRS"
}

variable "vm_ami_publisher_azure" {
  description = "AMI publisher da VM usado na Azure"
  type        = string
  default     = "Canonical"
}

variable "vm_ami_offer_azure" {
  description = "AMI offer da VM usado na Azure"
  type        = string
  default     = "0001-com-ubuntu-server-jammy"
}

variable "vm_ami_sku_azure" {
  description = "AMI sku da VM usado na Azure"
  type        = string
  default     = "22_04-lts"
}

variable "vm_ami_version_azure" {
  description = "AMI version da VM usado na Azure"
  type        = string
  default     = "latest"
}

variable "tag_id_aws" {
  description = "Tag usado na AWS"
  type        = string
  default     = "vm-terraform-github"
}

variable "tag_id_azure" {
  description = "Tag usado na AWS"
  type        = map(string)
  default = {
    owner      = "marco-qa"
    managed-by = "terraform"
  }
}