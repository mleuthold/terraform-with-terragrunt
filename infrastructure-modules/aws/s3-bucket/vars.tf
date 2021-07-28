variable "bucket_name" {
  type = string
}

variable "versioning" {
  type    = bool
  default = false
}

variable "environment" {
  type    = string
  default = "live"
}
