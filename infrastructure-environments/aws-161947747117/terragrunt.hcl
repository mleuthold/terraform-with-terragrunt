remote_state {
  backend = "s3"
  config = {
    bucket = "161947747117-terraform-state"
    key    = "${basename(get_parent_terragrunt_dir())}/${path_relative_to_include()}/terraform.tfstate"
    region = "eu-west-1"

    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

iam_role = "arn:aws:iam::161947747117:role/TerraformTerragrunt"

inputs = {
}
