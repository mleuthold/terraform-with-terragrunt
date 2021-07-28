include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../infrastructure-modules/datadog/dashboard"
}

inputs = {
  datadog_api_key       = ""
  datadog_app_key       = ""
  datadog_metric_prefix = "my.prefix"
  datadog_env_default   = "prod"
  datadog_name_prefix   = "[EXAMPLE APP]"
}
