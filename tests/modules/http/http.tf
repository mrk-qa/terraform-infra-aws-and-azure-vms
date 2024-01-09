data "http" "index" {
  url    = var.endpoint
  method = "GET"

  retry {
    attempts     = 15
    min_delay_ms = 5000
  }
}

variable "endpoint" {
  type = string
}