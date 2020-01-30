provider "kafka" {
  bootstrap_servers = [var.bootstrap_servers, ]
  skip_tls_verify   = true
  tls_enabled       = true
}

terraform {
  backend "s3" {}
}

resource "kafka_topic" "default" {
  name               = var.name
  replication_factor = 3
  partitions         = 5

  config = {
    "compression.type" = "gzip"
    "cleanup.policy"   = "delete"
  }
}