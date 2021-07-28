provider "google" {
  credentials = file(var.file_path_to_credentials)
  project     = var.project # "marketing-bi-219517"
  region      = var.region
  zone        = var.zone
}

terraform {
  backend "gcs" {}
}

resource "google_storage_bucket" "bucket" {
  name               = var.name
  location           = var.location
  force_destroy      = false
  bucket_policy_only = true

  labels = var.labels

  # We explicitly prevent destruction using terraform. Remove this only if you really know what you're doing.
  lifecycle {
    prevent_destroy = true
  }
}

resource "google_storage_bucket_iam_binding" "binding" {
  bucket  = google_storage_bucket.bucket.name
  role    = "roles/storage.objectViewer"
  members = var.storage_object_viewer_members
}
