variable "aws_key_pub" {
  description = "Chave pública para a vm na AWS"
  type        = string

  validation {
    condition     = can(regex("^(ssh-rsa AAAAB3NzaC1yc2|ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNT|ecdsa-sha2-nistp384 AAAAE2VjZHNhLXNoYTItbmlzdHAzODQAAAAIbmlzdHAzOD|ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1Mj|ssh-ed25519 AAAAC3NzaC1lZDI1NTE5|ssh-dss AAAAB3NzaC1kc3)[0-9A-Za-z+/]+[=]{0,3}( .*)?$", var.aws_key_pub))
    error_message = "Public Key Regex did not match expected"
  }
}

variable "azure_key_pub" {
  description = "Chave pública para a vm na Azure"
  type        = string

  validation {
    condition     = can(regex("^(ssh-rsa AAAAB3NzaC1yc2|ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNT|ecdsa-sha2-nistp384 AAAAE2VjZHNhLXNoYTItbmlzdHAzODQAAAAIbmlzdHAzOD|ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1Mj|ssh-ed25519 AAAAC3NzaC1lZDI1NTE5|ssh-dss AAAAB3NzaC1kc3)[0-9A-Za-z+/]+[=]{0,3}( .*)?$", var.azure_key_pub))
    error_message = "Public Key Regex did not match expected"
  }
}

variable "location_azure" {
  description = "Região onde os recursos serão criados"
  type        = string
  default     = "East US"
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

  validation {
    condition     = can(regex("^ami-[a-f0-9]{8,17}$", var.ami_aws))
    error_message = "AMI Regex did not match expected"
  }
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

variable "environment" {
  description = "Ambiente no qual os recursos serão criados"
  type        = string
  default     = null
}