output "lot_bucket_arn" {
  value       = aws_s3_bucket.lot_data.arn
  description = ""
}

output "log_bucket_arn" {
  value       = aws_s3_bucket.log_bucket.arn
  description = ""
}
