resource "datadog_monitor" "default" {
  evaluation_delay = 0
  include_tags     = true
  locked           = false

  message = var.message

  name                = var.name
  new_host_delay      = 300
  no_data_timeframe   = 0
  notify_audit        = false
  notify_no_data      = false
  query               = var.query
  renotify_interval   = 0
  require_full_window = false

  tags = var.tags

  threshold_windows = {}

  thresholds = var.thresholds

  timeout_h = 0
  type      = "query alert"
}
