provider "google" {
  credentials = file(var.file_path_to_credentials)
  project     = var.project
  region      = var.region
  zone        = var.zone
}

terraform {
  backend "gcs" {}
}

resource "google_bigquery_table" "view" {
  labels      = var.labels
  dataset_id  = var.dataset_name
  table_id    = var.view_name
  description = var.description

  view {
    query          = var.query
    use_legacy_sql = false
  }
}
