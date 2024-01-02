variable "aws_key_pub" {
  description = "Chave pública para a vm na AWS"
  type        = string
}

variable "azure_key_pub" {
  description = "Chave pública para a vm na Azure"
  type        = string
}

variable "location" {
  description = "Região onde os recursos serão criados"
  type        = string
  default     = "East US 2"
}
