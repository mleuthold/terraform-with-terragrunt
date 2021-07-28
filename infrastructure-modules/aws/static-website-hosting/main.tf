provider "aws" {
  alias   = "default"
  region  = "eu-west-1"
  version = "~> 3.14"
}

provider "aws" {
  alias   = "lambda-edge-support-in-cloudfront"
  region  = "us-east-1"
  version = "~> 3.14"
}

terraform {
  backend "s3" {}
}

resource "aws_s3_bucket" "bucket" {
  acl           = "private"
  bucket        = var.bucket_name
  force_destroy = true

  website {
    error_document = "error.html"
    index_document = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "bucket_access" {
  bucket = aws_s3_bucket.bucket.id

  policy = templatefile("policy.tpl", { ORIGIN_ACCESS_IDENTITY_ARN = aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn, S3_BUCKET_ARN = aws_s3_bucket.bucket.arn })
}

locals {
  s3_origin_id = "S3-${aws_s3_bucket.bucket.id}"
}

resource "aws_cloudfront_distribution" "s3_distribution" {


  default_root_object = "index.html"
  enabled             = true
  is_ipv6_enabled     = true

  default_cache_behavior {
    allowed_methods           = ["GET", "HEAD"]
    cached_methods            = ["GET", "HEAD"]
    compress                  = false
    field_level_encryption_id = ""
    forwarded_values {
      query_string = false
      cookies {
        forward = "all"
      }
    }
    target_origin_id = local.s3_origin_id


    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0

    lambda_function_association {
      event_type   = "viewer-request"
      include_body = true
      lambda_arn   = aws_lambda_function.authentication.qualified_arn
    }
  }

  origin {
    # use the regional domain name in order to avoid a redirect from CloudFront to S3 website URL
    # https://stackoverflow.com/questions/38735306/aws-cloudfront-redirecting-to-s3-bucket
    domain_name = aws_s3_bucket.bucket.bucket_regional_domain_name
    origin_id   = local.s3_origin_id
    origin_path = var.origin_path #"/data_docs/local_site"
    s3_origin_config {
      origin_access_identity = "origin-access-identity/cloudfront/${aws_cloudfront_origin_access_identity.origin_access_identity.id}"
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
    minimum_protocol_version       = "TLSv1"
  }
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {

  comment = "access-identity-lambda-authentication"
}

resource "aws_iam_role" "lambda" {
  name        = var.lambda_iam_role_name #"lambda-execute-role"
  description = "Allows Lambda functions to call AWS services on your behalf."
  assume_role_policy = jsonencode(
    {
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Principal = {
            Service = [
              "lambda.amazonaws.com",
              "edgelambda.amazonaws.com",
            ]
          }
        },
      ]
      Version = "2012-10-17"
    }

  )
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AWSLambdaExecute"
  role       = aws_iam_role.lambda.id
}

resource "aws_lambda_function" "authentication" {

  provider = aws.lambda-edge-support-in-cloudfront

  filename      = data.archive_file.lambda_zip_inline.output_path
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda.arn
  handler       = "index.handler"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = data.archive_file.lambda_zip_inline.output_base64sha256

  runtime = "nodejs12.x"
  publish = true

}

data "archive_file" "lambda_zip_inline" {

  //  provider = aws.lambda-edge-support-in-cloudfront

  type        = "zip"
  output_path = "/tmp/lambda_zip_inline.zip"
  source {
    content  = <<EOF
exports.handler = (event, context, callback) => {

  // Get the request and its headers
  const request = event.Records[0].cf.request;
  const headers = request.headers;

  // Specify the username and password to be used
  const user = 'user';
  const pw = 'password';

  // Build a Basic Authentication string
  const authString = 'Basic ' + new Buffer(user + ':' + pw).toString('base64');

  // Challenge for auth if auth credentials are absent or incorrect
  if (typeof headers.authorization == 'undefined' || headers.authorization[0].value != authString) {
    const response = {
      status: '401',
      statusDescription: 'Unauthorized',
      body: 'Unauthorized',
      headers: {
        'www-authenticate': [{key: 'WWW-Authenticate', value:'Basic'}]
      },
    };
    callback(null, response);
  }

  // User has authenticated
  callback(null, request);
};

// we are beautiful unicorns
EOF
    filename = "index.js"
  }
}
