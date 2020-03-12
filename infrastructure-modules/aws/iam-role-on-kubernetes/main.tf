provider "aws" {
  region = "eu-west-1"
}

terraform {
  backend "s3" {}
}

resource "aws_iam_role" "iam_role_on_kubernetes" {
  name = var.iam_role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    },
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "arn:aws:iam::ARBITRARY_AWS_ID:role/ARBITRARY_ROLE_NAME"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  path = "/"

  tags = map(
    "module", "iam-role-on-kubernetes",
  )
}

# MANAGED POLICY
resource "aws_iam_role_policy_attachment" "managed_policy_attachment_s3_full_access" {
  role       = aws_iam_role.iam_role_on_kubernetes.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "managed_policy_attachment_athena_full_access" {
  role       = aws_iam_role.iam_role_on_kubernetes.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonAthenaFullAccess"
}

# CUSTOM POLICY
resource "aws_iam_policy" "custom_policy" {
  name = "custom-policy-${var.iam_role_name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "VisualEditor0",
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::ARBITRARY-BUCKET-NAME/*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "custom_policy_attachment" {
  role       = aws_iam_role.iam_role_on_kubernetes.name
  policy_arn = aws_iam_policy.custom_policy.arn
}
