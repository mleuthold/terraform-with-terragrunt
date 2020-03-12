# datadog_dashboard.pipeline:
resource "datadog_dashboard" "pipeline" {
  description = "General overview"

  is_read_only = false
  layout_type  = "ordered"
  notify_list  = []
  title        = "pipeline"

  template_variable {
    default = "prod"
    name    = "env"
    prefix  = "env"
  }

  template_variable {
    default = "default"
    name    = "kube_namespace"
    prefix  = "kube_namespace"
  }

  template_variable {
    default = "prod-v1"
    name    = "cluster"
    prefix  = "cluster"
  }

  widget {
    layout = {}

    group_definition {
      layout_type = "ordered"
      title       = "Collector"

      widget {
        layout = {}

        query_value_definition {
          autoscale   = true
          custom_unit = "msg"
          precision   = 0
          time        = {}
          title       = "messages in rate"

          request {
            aggregator = "last"
            q          = "sum:kafka.topic.messages_in.rate{topic:collector-good,$env}"

            conditional_formats {
              comparator = "<"
              hide_value = false
              palette    = "white_on_red"
              value      = 3
            }

            conditional_formats {
              comparator = "<"
              hide_value = false
              palette    = "white_on_yellow"
              value      = 20
            }

            conditional_formats {
              comparator = ">="
              hide_value = false
              palette    = "white_on_green"
              value      = 20
            }
          }
        }
      }

      widget {
        layout = {}

        timeseries_definition {
          show_legend = false
          time        = {}
          title       = "messages in rate"

          event {
            q = "tags:namespace:collector Created container"
          }

          request {
            display_type = "area"
            q            = "sum:kafka.topic.messages_in.rate{$env,topic:collector-good} by {host}"

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "dog_classic"
            }
          }

          yaxis {
            include_zero = false
            min          = "0"
          }
        }
      }

      widget {
        layout = {}

        query_value_definition {
          autoscale   = true
          custom_unit = "#"
          precision   = 2
          time        = {}
          title       = "container restarts"

          request {
            aggregator = "last"
            q          = "sum:kubernetes.containers.restarts{$kube_namespace,$cluster,$env,kube_deployment:collector}"

            conditional_formats {
              comparator = ">"
              hide_value = false
              palette    = "white_on_red"
              value      = 10
            }

            conditional_formats {
              comparator = ">="
              hide_value = false
              palette    = "white_on_yellow"
              value      = 3
            }

            conditional_formats {
              comparator = "<"
              hide_value = false
              palette    = "white_on_green"
              value      = 3
            }
          }
        }
      }

      widget {
        layout = {}

        query_value_definition {
          autoscale   = true
          custom_unit = "pod"
          precision   = 2
          time        = {}
          title       = "number of pods"

          request {
            aggregator = "last"
            q          = "sum:kubernetes.containers.running{$kube_namespace,$cluster,$env,kube_deployment:collector}"

            conditional_formats {
              comparator = ">="
              hide_value = false
              palette    = "white_on_green"
              value      = 2
            }

            conditional_formats {
              comparator = "<"
              hide_value = false
              palette    = "white_on_red"
              value      = 2
            }
          }
        }
      }

      widget {
        layout = {}

        timeseries_definition {
          show_legend = false
          time        = {}
          title       = "number of pods"

          request {
            display_type = "bars"
            q            = "sum:kubernetes.containers.running{$kube_namespace,$cluster,$env,kube_deployment:collector} by {host}"

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "dog_classic"
            }
          }
        }
      }

      widget {
        layout = {}

        timeseries_definition {
          show_legend = false
          time        = {}
          title       = "cpu usage"

          request {
            display_type = "line"

            process_query {
              filter_by = [
                "kube_deployment:collector",
                "$kube_namespace",
                "$env",
              ]

              limit  = 10
              metric = "process.stat.cpu.total_pct"
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "dog_classic"
            }
          }

          yaxis {
            include_zero = false
            max          = "110"
          }
        }
      }

      widget {
        layout = {}

        timeseries_definition {
          show_legend = false
          time        = {}
          title       = "memory usage"

          request {
            display_type = "area"
            q            = "sum:kubernetes.memory.usage{$kube_namespace,$cluster,$env,kube_deployment:collector} by {host}"

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "dog_classic"
            }
          }
        }
      }

      widget {
        layout = {}

        timeseries_definition {
          show_legend = false
          time        = {}
          title       = "Kafka producer outgoing byte rate"

          request {
            display_type = "line"
            q            = "sum:jmx.kafka.producer.outgoing_byte_rate{env:prod,app:collector,$env}"

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "dog_classic"
            }
          }
        }
      }

      widget {
        layout = {}

        timeseries_definition {
          show_legend = false
          time        = {}
          title       = "Snowplow accepted requests (cumulated since start)"

          event {
            q = "tags:namespace:collector Created container "
          }

          request {
            display_type = "area"
            q            = "sum:jmx.com.snowplowanalytics.snowplow.requests{$env,type:scalacollector} by {host}"

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "dog_classic"
            }
          }

          yaxis {
            include_zero = false
          }
        }
      }

      widget {
        layout = {}

        timeseries_definition {
          show_legend = false
          time        = {}
          title       = "Kafka producer bytes in buffer"

          request {
            display_type = "area"
            q            = "avg:jmx.kafka.producer.buffer_available_bytes{type:producer-metrics,$env,app:collector} by {host}"

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "dog_classic"
            }
          }
        }
      }

      widget {
        layout = {}

        timeseries_definition {
          show_legend = false
          time        = {}
          title       = "LOGS warnings and errors"

          request {
            display_type = "bars"

            log_query {
              compute = {
                "aggregation" = "count"
              }

              index = "main"

              search = {
                "query" = "$kube_namespace $env service:collector -status:info"
              }

              group_by {
                facet = "status"
                limit = 10

                sort = {
                  "aggregation" = "count"
                  "order"       = "desc"
                }
              }
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "dog_classic"
            }
          }
        }
      }
    }
  }
}
