terraform {
  backend "s3" {}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.52.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "bucket_logs" {
  bucket = "${data.aws_caller_identity.current.account_id}-data-${var.environment}-logs"
  acl    = "log-delivery-write"

  // delete logs older than 90 days
  lifecycle_rule {
    id      = "logs"
    prefix  = "logs/"
    enabled = true

    expiration {
      days = 60
    }

    noncurrent_version_expiration {
      days = 60
    }
  }

  // delete partitioned logs older than 90 days
  lifecycle_rule {
    id      = "logs-partitioned"
    prefix  = "logs-partitioned/"
    enabled = true

    expiration {
      days = 365
    }

    noncurrent_version_expiration {
      days = 365
    }
  }

  // delete parquet version of logs older than 30 days
  lifecycle_rule {
    id      = "logs-as-parquet"
    prefix  = "logs-as-parquet/"
    enabled = true

    expiration {
      days = 31
    }

    noncurrent_version_expiration {
      days = 31
    }
  }

  tags = {
    Name        = "Logs about data lake for environment ${var.environment}"
    Environment = var.environment
  }
}

resource "aws_s3_bucket" "bucket_data" {
  bucket = "${data.aws_caller_identity.current.account_id}-data-${var.environment}"
  acl    = "private"

  request_payer = "BucketOwner"

  logging {
    target_bucket = aws_s3_bucket.bucket_logs.bucket
    target_prefix = "logs/data-${var.environment}/"
  }

  tags = {
    Name        = "Data Lake for environment ${var.environment}"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_metric" "bucket_metrics" {
  bucket = aws_s3_bucket.bucket_data.bucket
  name   = "metric-${var.environment}"

  filter {
    prefix = "${var.environment}/"
  }
}

resource "aws_s3_bucket_metric" "bucket_metric" {
  bucket = aws_s3_bucket.bucket_data.bucket
  name   = "all-bucket"
}

resource "aws_s3_bucket_policy" "bucket_data_policy" {
  bucket = aws_s3_bucket.bucket_data.bucket

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "accounts-read-${var.environment}",
    "Statement": [
        {
            "Sid": "accounts-read",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:Get*",
                "s3:ListBucket"
            ],
            "Resource": [
                "${aws_s3_bucket.bucket_data.arn}/*",
                "${aws_s3_bucket.bucket_data.arn}"
            ],
            "Condition": {
                "StringEquals": {
                    "aws:PrincipalOrgID": "${var.PrincipalOrgID}"
                }
            }
        }
    ]
}
POLICY

}

resource "aws_s3_bucket_policy" "bucket_logs_policy" {
  bucket = aws_s3_bucket.bucket_logs.bucket

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Allow full bucket access to other root accounts",
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                    "arn:aws:iam::ARBITRARY_AWS_ID:root"
                ]
            },
            "Action": "s3:*",
            "Resource": [
                "${aws_s3_bucket.bucket_logs.arn}",
                "${aws_s3_bucket.bucket_logs.arn}/*"
            ]
        }
    ]
}
POLICY

}
