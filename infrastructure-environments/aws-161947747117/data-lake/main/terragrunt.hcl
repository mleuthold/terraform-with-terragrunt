include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../..//infrastructure-modules/aws/data-lake-dataset"
}

inputs = {
  environment = "main"
}
