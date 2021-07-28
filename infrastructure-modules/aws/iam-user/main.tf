provider "aws" {
  region  = "eu-west-1"
  version = "~> 3.14"
}

terraform {
  backend "s3" {}
}

resource "aws_iam_user" "user" {
  name = var.user_name
}

resource "aws_iam_access_key" "default_access_key" {
  user = aws_iam_user.user.name
}

resource "aws_iam_user_policy" "default_policy" {
  name = "default"
  user = aws_iam_user.user.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "cloudfront:CreateInvalidation"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_user_policy" "s3_policy" {
  name = "s3"
  user = aws_iam_user.user.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
