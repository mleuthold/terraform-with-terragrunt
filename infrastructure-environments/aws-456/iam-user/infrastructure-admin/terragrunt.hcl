include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../infrastructure-modules/aws/iam-user"
}

inputs = {
  user_name = "infrastructure-admin"
}
