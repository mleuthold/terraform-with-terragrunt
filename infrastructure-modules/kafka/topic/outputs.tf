output "kafka_topic_name" {
  description = "The name of the Kafka topic"
  value       = kafka_topic.default.name
}
