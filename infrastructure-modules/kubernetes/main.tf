provider "kubernetes" {
  host                   = var.kubernetes_server
  cluster_ca_certificate = base64decode(var.kubernetes_cluster_ca_certificate)

  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    command     = "aws-iam-authenticator"
    args        = ["token", "-i", var.kubernetes_cluster]
  }
}

terraform {
  backend "s3" {}
}

resource "kubernetes_config_map" "example" {
  metadata {
    name      = var.config_name
    namespace = var.kubernetes_namespace
  }

  data = {
    api_host = "myhost:443"
    db_host  = "dbhost:5432"
  }
}
