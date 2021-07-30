include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../infrastructure-modules/gcp/container_registry"
}

inputs = {
  location = "EU"
}
