# integration test

run "setup_vm_azure" {
  command = apply

  variables {
    vm_name_azure = "vm-terraform-webserver-validation"
    environment   = "test"
  }

  assert {
    condition     = azurerm_linux_virtual_machine.vm.name == "vm-terraform-webserver-validation"
    error_message = "Virtual Machine name did not match expected"
  }
}

run "webserver_is_running_on_azure" {
  command = plan

  module {
    source = "./tests/modules/http"
  }

  variables {
    endpoint = run.setup_vm_azure.webserver_azure_url
  }

  assert {
    condition     = data.http.index.status_code == 200
    error_message = "Website responded with HTTP status ${data.http.index.status_code}"
  }

  assert {
    condition     = data.http.index.response_body == "Hello, Marco!\n"
    error_message = "Website responded with body: ${data.http.index.response_body}"
  }
}