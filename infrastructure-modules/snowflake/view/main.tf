provider "snowflake" {
  account  = var.snowflake_account
  username = var.snowflake_username
  password = var.snowflake_password
}

terraform {
  backend "s3" {}
}

resource "snowflake_view" "view" {
  comment   = var.view_comment
  database  = var.database_name
  is_secure = false
  name      = var.view_name
  schema    = var.schema_name
  statement = var.view_statement
}
