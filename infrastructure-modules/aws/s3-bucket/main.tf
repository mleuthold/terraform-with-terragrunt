provider "aws" {
  region = "eu-west-1"
}

terraform {
  backend "s3" {}
}

resource "aws_s3_bucket" "bucket" {
  acl           = "private"
  bucket        = var.bucket_name
  force_destroy = false
  tags = {
    environment = var.environment
  }
}

resource "aws_s3_bucket_metric" "s3_metrics" {
  bucket = aws_s3_bucket.bucket.bucket
  name   = "entire-bucket"
}

