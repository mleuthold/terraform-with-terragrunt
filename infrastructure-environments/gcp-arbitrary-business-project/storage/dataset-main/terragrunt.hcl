include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../infrastructure-modules/gcp/storage"
}

inputs = {
  name                          = "dataset-main"
  location                      = "US"
  storage_object_viewer_members = []
}
