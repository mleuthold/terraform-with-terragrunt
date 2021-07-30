include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../infrastructure-modules/gcp/storage"
}

inputs = {
  name                          = "dataset-intermediate"
  location                      = "US"
  storage_object_viewer_members = []
}
