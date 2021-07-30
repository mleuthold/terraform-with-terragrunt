remote_state {
  backend = "gcs"
  config = {
    bucket      = "tf-state-live"
    prefix      = "${basename(get_parent_terragrunt_dir())}/${path_relative_to_include()}"
    credentials = pathexpand("~/.google_cloud_credentials/infrastructure-live.json")
    project     = "martin-leuthold"
    location    = "us"
  }
}

inputs = {
  file_path_to_credentials = "~/.google_cloud_credentials/infrastructure-live.json"
  project                  = "martin-leuthold"
  region                   = "us-east1"
  zone                     = "us-east1-b"
  labels = {
    environment  = "live"
    project_name = "arbitrary-business-project"
  }
}
