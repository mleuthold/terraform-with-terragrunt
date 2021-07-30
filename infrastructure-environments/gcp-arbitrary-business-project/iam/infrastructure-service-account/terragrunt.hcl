include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../infrastructure-modules/gcp/iam"
}

inputs = {
  account_id   = "infrastructure-service-account"
  display_name = "Infrastructure Service Account"
}
