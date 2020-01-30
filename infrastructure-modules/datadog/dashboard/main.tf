provider "datadog" {
  version = "~> 2.5"
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

terraform {
  backend "s3" {}
}

resource "datadog_dashboard" "kubernetes_spark" {
  title        = "Spark app - example pipeline (${upper(var.datadog_env_default)})"
  description  = "Spark monitoring"
  layout_type  = "ordered"
  is_read_only = false

  template_variable {
    default = var.datadog_env_default
    name    = "env"
    prefix  = "env"
  }

  widget {
    group_definition {
      layout_type = "ordered"
      title       = "[Streaming] timeseries metrics"

      widget {
        timeseries_definition {
          show_legend = false
          title       = "[Spark-executors] Number of executors"
          title_size  = "16"
          title_align = "left"

          request {
            q            = "max:spark.executor.count{kube_deployment:example-app}, -1"
            display_type = "bars"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
          }
        }
      }
    }
  }

  widget {
    group_definition {
      layout_type = "ordered"
      title       = "[Streaming] query value metrics"

      widget {
        query_value_definition {
          title       = "[Spark-executor] Number of executors"
          title_size  = "16"
          title_align = "left"
          time = {
            live_span = "1m"
          }
          custom_unit = "#"
          precision   = 0
          autoscale   = true

          request {
            q          = "max:spark.executor.count{app_name:example-app} - 1"
            aggregator = "last"
            conditional_formats {
              comparator = "<"
              palette    = "white_on_red"
              value      = 1
              hide_value = false
            }
            conditional_formats {
              comparator = ">="
              palette    = "white_on_green"
              value      = 1
              hide_value = false
            }
          }
        }
      }
    }
  }
}
