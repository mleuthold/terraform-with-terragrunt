output "airflow_id" {
  description = "ID of Composer instance."
  value       = google_composer_environment.airflow.id
}

output "airflow_name" {
  description = "Name of Composer instance."
  value       = google_composer_environment.airflow.name
}

output "airflow_gke_cluster" {
  description = "Name of the GKE cluster for Airflow."
  value       = google_composer_environment.airflow.config[0].gke_cluster
}
