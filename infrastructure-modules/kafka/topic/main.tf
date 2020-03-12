provider "kafka" {
  bootstrap_servers = [var.kafka_bootstrap_servers, ]
  skip_tls_verify   = true
  tls_enabled       = true
}

terraform {
  backend "s3" {}
}

resource "kafka_topic" "default" {
  name               = var.name
  replication_factor = var.replication_factor
  partitions         = var.partitions

  config = {
    "compression.type" = "gzip"
    "cleanup.policy"   = "delete"
  }
}