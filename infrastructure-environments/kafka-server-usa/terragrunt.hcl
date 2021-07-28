remote_state {
  backend = "s3"
  config = {
    bucket = "terraform-state-dev"
    key    = "${basename(get_parent_terragrunt_dir())}/${path_relative_to_include()}/terraform.tfstate"
    region = "eu-west-1"

    dynamodb_table = "terraform-state-lock-dev"
    encrypt        = true
  }
}

iam_role = "arn:aws:iam::<AWS_ACCOUNT_ID>:role/mgmt-role"
