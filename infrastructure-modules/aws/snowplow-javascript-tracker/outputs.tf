output "s3_bucket_arn" {
  description = ""
  value       = aws_s3_bucket.static_content.arn
}

output "s3_bucket_name" {
  description = ""
  value       = aws_s3_bucket.static_content.bucket
}

output "cloudfront_distribution_arn" {
  description = ""
  value       = aws_cloudfront_distribution.cdn.arn
}

output "cloudfront_distribution_id" {
  description = ""
  value       = aws_cloudfront_distribution.cdn.id
}

output "snowplow_js_url" {
  description = "Link to Snowplow JS file on the CloudFront distribution."
  value       = "https://${aws_cloudfront_distribution.cdn.domain_name}/${var.js_name}"
}