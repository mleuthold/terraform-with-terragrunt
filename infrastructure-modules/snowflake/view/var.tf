variable "snowflake_account" {
  type    = string
}

variable "snowflake_username" {
  type    = string
}

variable "snowflake_password" {
  type = string
}

variable "database_name" {
  type = string
}

variable "schema_name" {
  type = string
}

variable "view_name" {
  type = string
}

variable "view_statement" {
  type = string
}

variable "view_comment" {
  default = ""
  type    = string
}