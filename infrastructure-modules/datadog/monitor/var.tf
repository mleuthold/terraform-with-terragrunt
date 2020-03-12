variable "name" {
  description = ""
  type        = string
}

variable "message" {
  description = ""
  type        = string
}

variable "query" {
  description = ""
  type        = string
}

variable "tags" {
  description = ""
  type        = list(string)
}

variable "thresholds" {
  description = ""
  type        = map(string)
}
