output "repo_id" {
  description = "ID of repo."
  value       = google_sourcerepo_repository.repo.id
}

output "repo_name" {
  description = "Name of repo."
  value       = google_sourcerepo_repository.repo.name
}

output "trigger_id" {
  description = "Trigger ID"
  value       = google_cloudbuild_trigger.main_trigger.id
}
output "trigger_name" {
  description = "Trigger name"
  value       = google_cloudbuild_trigger.main_trigger.name
}
