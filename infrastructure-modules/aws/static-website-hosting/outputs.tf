output "s3_bucket_arn" {
  description = "Checkpoints, watermarks and scripts of streaming applications"
  value       = aws_s3_bucket.bucket.arn
}

output "s3_bucket_name" {
  description = "Checkpoints, watermarks and scripts of streaming applications"
  value       = aws_s3_bucket.bucket.bucket
}

output "cloudfront_web_link" {
  description = "Web link to access CloudFront distribution in browser"
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
}
