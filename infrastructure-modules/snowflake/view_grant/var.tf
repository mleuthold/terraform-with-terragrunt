variable "snowflake_account" {
  type    = string
}

variable "snowflake_username" {
  type    = string
}

variable "snowflake_password" {
  type = string
}

variable "snowflake_consumer_roles" {
  type = list(string)
}

variable "database_name" {
  type = string
}

variable "schema_name" {
  type = string
}

variable "privilege" {
  type = string
}

variable "view_name" {
  type = string
}