output "repo_id" {
  description = "ID of bucket."
  value       = google_storage_bucket.bucket.id
}

output "repo_name" {
  description = "Name of bucket."
  value       = google_storage_bucket.bucket.name
}
