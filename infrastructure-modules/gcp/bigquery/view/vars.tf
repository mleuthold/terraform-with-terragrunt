variable "file_path_to_credentials" { type = string }

variable "project" { type = string }

variable "region" { type = string }

variable "zone" { type = string }

variable "labels" { type = map(any) }

variable "dataset_name" { type = string }

variable "view_name" { type = string }

variable "query" { type = string }

variable "description" {
  type    = string
  default = "created with Terraform"
}
