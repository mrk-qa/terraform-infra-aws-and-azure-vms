# integration test

run "setup_vm_aws" {
  command = apply

  variables {
    tag_id_aws  = "vm-terraform-webserver-validation"
    environment = "test"
  }

  assert {
    condition     = aws_instance.vm.tags == tomap({ "Name" = "vm-terraform-webserver-validation" })
    error_message = "Instance tags did not match expected"
  }
}

run "webserver_is_running_on_aws" {
  command = plan

  module {
    source = "./tests/modules/http"
  }

  variables {
    endpoint = run.setup_vm_aws.webserver_aws_url
  }

  assert {
    condition     = data.http.index.response_body == "Hello, World!\n"
    error_message = "Website responded with body: ${data.http.index.response_body}"
  }

  assert {
    condition     = data.http.index.status_code == 200
    error_message = "Website responded with HTTP status ${data.http.index.status_code}"
  }
}