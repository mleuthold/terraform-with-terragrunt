provider "snowflake" {
  account  = var.snowflake_account
  username = var.snowflake_username
  password = var.snowflake_password
}

terraform {
  backend "s3" {}
}

resource "snowflake_view_grant" "grant" {
  database_name = var.database_name
  privilege     = var.privilege
  roles         = var.snowflake_consumer_roles
  schema_name   = var.schema_name
  view_name     = var.view_name
}
