module "kafka_topic_collector_good" {
  source = "../monitor"
  name   = "Collector - Kafka topic messages in rate is too low"

  message = <<EOT
              @pagerduty-TEAMNAME @teams-TEAMCHANNEL
              EOT

  query = "avg(last_10m):sum:kafka.topic.messages_in.rate{topic:collector-good,${local.env}} < 15"
  tags  = local.tags

  thresholds = {
    "critical" = "15.0"
  }
}

module "kafka_topic_enricher_good" {
  source = "../monitor"
  name   = "Enricher - Kafka topic messages in rate is too low"

  message = <<EOT
              @pagerduty-TEAMNAME @teams-TEAMCHANNEL
              EOT

  query = "avg(last_10m):sum:kafka.topic.messages_in.rate{topic:enricher-good,${local.env}} < 15"
  tags  = local.tags_non_critical

  thresholds = {
    "critical" = "15.0"
  }
}
