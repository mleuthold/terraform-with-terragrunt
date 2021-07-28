provider "google" {
  credentials = file(var.file_path_to_credentials)
  project     = var.project # "marketing-bi-219517"
  region      = var.region
  zone        = var.zone
}

terraform {
  backend "gcs" {}
}

resource "google_service_account" "service_account" {
  account_id   = var.account_id
  display_name = var.display_name
}

resource "google_project_iam_member" "project" {
  role   = "roles/bigquery.admin"
  member = "serviceAccount:${element(split("/", google_service_account.service_account.id), 3)}"
}
