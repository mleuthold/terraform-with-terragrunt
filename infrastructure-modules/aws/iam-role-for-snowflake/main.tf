provider "aws" {
  region = "eu-west-1"
}

terraform {
  backend "s3" {}
}

data "aws_caller_identity" "current" {}

resource "aws_iam_role" "snowflake_iam_role" {
  name = var.iam_role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "arn:aws:iam::ARBITRARY_AWS_ID:role/ARBITRARY_ROLE_NAME"
        ]
      },
      "Action": "sts:AssumeRole"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "${var.snowflake_iam_arn}"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringLike": {
          "sts:ExternalId": "${var.snowflake_external_id}"
        }
      }
    }
  ]
}
EOF

  path = "/"

  tags = {
    pipeline = "snowflake"
  }
}

resource "aws_iam_role_policy_attachment" "snowflake_managed_policy_athena" {
  role       = aws_iam_role.snowflake_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonAthenaFullAccess"
}

resource "aws_iam_role_policy_attachment" "snowflake_managed_policy_s3" {
  role       = aws_iam_role.snowflake_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}
