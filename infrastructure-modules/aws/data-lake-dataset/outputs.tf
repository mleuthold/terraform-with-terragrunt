output "bucket_data" {
  value       = aws_s3_bucket.bucket_data.arn
  description = ""
}

output "bucket_logs" {
  value       = aws_s3_bucket.bucket_logs.arn
  description = ""
}
