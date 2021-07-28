provider "google" {
  credentials = file(var.file_path_to_credentials)
  project     = var.project # "marketing-bi-219517"
  region      = var.region
  zone        = var.zone
}

terraform {
  backend "gcs" {}
}

resource "google_composer_environment" "airflow" {
  labels  = var.labels
  name    = var.name
  project = var.project
  region  = var.region

  config {
    node_count = 5

    node_config {
      disk_size_gb = 100
      machine_type = "projects/${var.project}/zones/${var.zone}/machineTypes/n1-standard-1"
      network      = "projects/${var.project}/global/networks/default"
      oauth_scopes = [
        "https://www.googleapis.com/auth/cloud-platform",
      ]
      service_account = var.service_account #"873550564100-compute@developer.gserviceaccount.com"
      tags            = []
      zone            = "projects/${var.project}/zones/${var.zone}"
    }

    software_config {
      airflow_config_overrides = {}
      env_variables = {
        "AIRFLOW_CONN_SSH_SERVER_A" = "ssh://username_a:${var.gcp_composer_ssh_key_passphrase}@1.2.3.4?key_file=%2Fhome%2Fairflow%2Fgcs%2Fdata%2Fid_rsa"
        "AIRFLOW_CONN_SSH_SERVER_B" = "ssh://username_b:${var.gcp_composer_ssh_key_passphrase}@5.6.7.8?key_file=%2Fhome%2Fairflow%2Fgcs%2Fdata%2Fid_rsa"
        "AIRFLOW_CONN_SLACK_HOOK"   = "http://XYZ"
      }
      image_version = "composer-1.10.4-airflow-1.10.6"
      pypi_packages = {
        "paramiko"  = ""
        "sshtunnel" = ""
      }
      python_version = "3"
    }
  }

  timeouts {}

  # We explicitly prevent destruction using terraform. Remove this only if you really know what you're doing.
  lifecycle {
    prevent_destroy = true
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name     = "cpu2-ram8"
  location = var.zone
  cluster  = element(split("/", google_composer_environment.airflow.config[0].gke_cluster), 5) #"us-east1-mbi-airflow-2-f67c624a-gke"

  autoscaling {
    max_node_count = 25
    min_node_count = 1
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    service_account = google_composer_environment.airflow.config[0].node_config[0].service_account

    preemptible  = true
    machine_type = "n1-standard-2"

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",

      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",

      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}


resource "google_container_node_pool" "secondary_preemptible_nodes" {
  name     = "cpu32-ram120"
  location = var.zone
  cluster  = element(split("/", google_composer_environment.airflow.config[0].gke_cluster), 5) #"us-east1-mbi-airflow-2-f67c624a-gke"

  autoscaling {
    max_node_count = 15
    min_node_count = 0
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    service_account = google_composer_environment.airflow.config[0].node_config[0].service_account

    preemptible  = true
    machine_type = "n1-standard-32"

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",

      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",

      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}
