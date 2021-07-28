variable "file_path_to_credentials" { type = string }

variable "project" { type = string }

variable "region" { type = string }

variable "zone" { type = string }

variable "dataset_name" { type = string }

variable "labels" { type = map(any) }

variable "external_table_name" { type = string }

variable "source_uri" { type = string }

variable "hive_partitioning_options" {
  type = list(map(string))
  default = [
    //    {
    //      mode = "AUTO"
    //      source_uri_prefix = "abc"
    //    }
  ]
}
