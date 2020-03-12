variable "datadog_api_key" {
  type = string
}
variable "datadog_app_key" {
  type = string
}

variable "datadog_env_default" {
  type = string
}

variable "datadog_name_prefix" {
  type = string
}

locals {
  env         = "env:prod"

  tags = [
    "env:prod",
    "service:spark-app",
    "team:teamname",
  ]

  tags_non_critical = concat(local.tags, ["is_critical:no"])
}
