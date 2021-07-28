provider "google" {
  credentials = file(var.file_path_to_credentials)
  project     = var.project # "marketing-bi-219517"
  region      = var.region
  zone        = var.zone
}

terraform {
  backend "gcs" {}
}

resource "google_sourcerepo_repository" "repo" {
  name = var.name #"my/repository"

  # We explicitly prevent destruction using terraform. Remove this only if you really know what you're doing.
  #  lifecycle {
  #    prevent_destroy = true
  #  }
}

resource "google_cloudbuild_trigger" "main_trigger" {
  description = "Triggers CI/CD pipeline in case of code change in main branch."
  disabled    = false
  filename    = "cloudbuild.yaml"
  //  id             = "projects/marketing-bi-219517/triggers/main-trigger"
  ignored_files  = []
  included_files = []
  name           = "${var.name}-main-trigger"
  project        = var.project
  substitutions  = {}

  timeouts {}

  trigger_template {
    branch_name  = "^master$"
    invert_regex = false
    project_id   = var.project
    repo_name    = var.name
  }
}
