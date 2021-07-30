include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../infrastructure-modules/gcp/storage"
}

inputs = {
  name                          = "dataset-raw"
  location                      = "US"
  storage_object_viewer_members = []
}
