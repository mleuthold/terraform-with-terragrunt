variable "name" {
  description = "The name of the Kafka topic"
  type        = string
}

variable "replication_factor" {
  description = "Factor for replication of Kafka topic"
  default     = 3
  type        = number
}

variable "partitions" {
  description = "Number of partitions of Kafka topic"
  default     = 5
  type        = number
}

variable "kafka_bootstrap_servers" {
  description = ""
  type        = string
}