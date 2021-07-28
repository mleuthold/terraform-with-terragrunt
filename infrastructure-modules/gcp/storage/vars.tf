variable "file_path_to_credentials" { type = string }

variable "project" { type = string }

variable "region" { type = string }

variable "zone" { type = string }

variable "name" { type = string }

variable "location" { type = string }

variable "labels" { type = map(string) }

variable "storage_object_viewer_members" { type = list(string) }
