provider "google" {
  credentials = file(var.file_path_to_credentials)
  project     = var.project # "marketing-bi-219517"
  region      = var.region
  zone        = var.zone
}

terraform {
  backend "gcs" {}
}

resource "google_container_registry" "registry" {
  location = var.location
}
