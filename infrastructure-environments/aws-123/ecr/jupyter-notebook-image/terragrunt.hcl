include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../..//infrastructure-modules/aws/ecr"
}

inputs = {
  ecr_name = "jupyter-notebook-image"
}
