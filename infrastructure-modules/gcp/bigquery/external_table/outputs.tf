output "table_id" {
  description = "Table ID"
  value       = google_bigquery_table.external_table.id
}

output "table_name" {
  description = "Table name"
  value       = google_bigquery_table.external_table.table_id
}
