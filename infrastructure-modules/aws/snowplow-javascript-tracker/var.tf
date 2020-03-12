variable "bucket" {
  description = "S3 bucket to store JavaScript file"
  type        = string
}

variable "tags" {
  description = "Tags for CloudFront distribution network"
  type        = map(string)
}

variable "snowplow_js_url" {
  description = "URL to sp.js"
  type        = string
}

variable "js_name" {
  description = "How do we rename sp.js?"
  type        = string
}