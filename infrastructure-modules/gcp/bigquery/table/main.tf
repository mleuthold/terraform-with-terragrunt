provider "google" {
  credentials = file(var.file_path_to_credentials)
  project     = var.project
  region      = var.region
  zone        = var.zone
}

terraform {
  backend "gcs" {}
}

resource "google_bigquery_table" "table" {
  labels      = var.labels
  dataset_id  = var.dataset_name
  table_id    = var.table_name
  description = var.description

  schema = var.schema

}
