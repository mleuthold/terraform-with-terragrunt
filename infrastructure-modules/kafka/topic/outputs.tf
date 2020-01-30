output "kafka_topic_id" {
  description = "The ID of the Kafka topic"
  value       = kafka_topic.default.id
}

output "kafka_topic_name" {
  description = "The name of the Kafka topic"
  value       = kafka_topic.default.name
}