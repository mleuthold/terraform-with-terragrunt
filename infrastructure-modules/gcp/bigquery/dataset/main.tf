provider "google" {
  credentials = file(var.file_path_to_credentials)
  project     = var.project
  region      = var.region
  zone        = var.zone
}

terraform {
  backend "gcs" {}
}

resource "google_bigquery_dataset" "dataset" {
  dataset_id  = var.name
  description = var.description
  location    = var.location

  labels = var.labels

  access {
    role          = "OWNER"
    special_group = "projectOwners"
  }
  access {
    role          = "READER"
    special_group = "projectReaders"
  }
  access {
    role          = "WRITER"
    special_group = "projectWriters"
  }

  # We explicitly prevent destruction using terraform. Remove this only if you really know what you're doing.
  lifecycle {
    prevent_destroy = true
  }
}
