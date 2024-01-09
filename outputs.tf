output "webserver_aws_url" {
  description = "Webserver endpoint URL"
  value       = "http://${aws_instance.vm.public_ip}"
}

output "webserver_azure_url" {
  description = "Webserver endpoint URL"
  value       = "http://${azurerm_linux_virtual_machine.vm.public_ip_address}"
}