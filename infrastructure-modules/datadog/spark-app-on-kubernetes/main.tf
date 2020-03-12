provider "datadog" {
  version = "~> 2.5"
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

terraform {
  backend "s3" {}
}