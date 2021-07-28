output "id" {
  description = "ID"
  value       = google_service_account.service_account.id
}

output "name" {
  description = "Name"
  value       = google_service_account.service_account.name
}
