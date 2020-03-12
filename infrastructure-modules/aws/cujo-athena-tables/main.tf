provider "aws" {
  region = "eu-west-1"
}

terraform {
  backend "s3" {}
}

data "aws_caller_identity" "current" {}

resource "aws_glue_catalog_database" "database" {
  name = "database_${var.environment}"
}

resource "aws_iam_role" "iam_role" {
  name = "iam-role-${var.environment}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "glue.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  path = "/service-role/"

  tags = {
    pipline = "pipeline"
  }
}

resource "aws_iam_role_policy_attachment" "managed_policy" {
  role       = aws_iam_role.iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

resource "aws_iam_policy" "glue_access_policy" {
  name   = "glue-access-policy-${var.environment}"
  policy = <<POLICY
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
POLICY
}

resource "aws_iam_role_policy_attachment" "glue_access_policy_attachment" {
  role       = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.glue_access_policy.arn
}

# RAW
resource "aws_glue_crawler" "crawler_raw_data" {
  database_name = aws_glue_catalog_database.database.name
  name          = "raw-data-${var.environment}"
  role          = aws_iam_role.iam_role.arn

  table_prefix = ""

  schedule = var.raw_data["schedule"]

  configuration = var.crawler_configuration

  schema_change_policy {
    update_behavior = "UPDATE_IN_DATABASE"
    delete_behavior = "DEPRECATE_IN_DATABASE"
  }

  s3_target {
    path = var.raw_data["path"]
  }
}

# PARQUET
resource "aws_glue_crawler" "crawler_master_data_parquet" {
  database_name = aws_glue_catalog_database.database.name
  name          = "master-data-parquet-${var.environment}"
  role          = aws_iam_role.iam_role.arn

  table_prefix = "master_data_"

  schedule = var.master_data_parquet["schedule"]

  configuration = var.crawler_configuration

  schema_change_policy {
    update_behavior = "UPDATE_IN_DATABASE"
    delete_behavior = "DEPRECATE_IN_DATABASE"
  }

  s3_target {
    path = var.master_data_parquet["path"]
  }
}

# JSON
resource "aws_glue_crawler" "crawler_master_data_json" {
  database_name = aws_glue_catalog_database.database.name
  name          = "master-data-json-${var.environment}"
  role          = aws_iam_role.iam_role.arn

  table_prefix = "master_data_"

  schedule = var.master_data_json["schedule"]

  configuration = var.crawler_configuration

  schema_change_policy {
    update_behavior = "UPDATE_IN_DATABASE"
    delete_behavior = "DEPRECATE_IN_DATABASE"
  }

  s3_target {
    path = var.master_data_json["path"]
  }
}
