variable "file_path_to_credentials" { type = string }

variable "project" { type = string }

variable "region" { type = string }

variable "zone" { type = string }

variable "name" { type = string }

variable "gcp_composer_ssh_key_passphrase" { type = string }

variable "labels" { type = map(any) }

variable "service_account" { type = string }
