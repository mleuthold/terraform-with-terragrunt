remote_state {
  backend = "s3"
  config = {
    bucket = "terraform-state-489198589229"
    key    = "${basename(get_parent_terragrunt_dir())}/${path_relative_to_include()}/terraform.tfstate"
    region = "eu-west-1"

    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

iam_role = "arn:aws:iam::123:role/infrastructure-admin"

inputs = {
}
