include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../infrastructure-modules/gcp/iam"
}

inputs = {
  account_id   = "ci-cd-service-account"
  display_name = "CI/CD Service Account"
}
