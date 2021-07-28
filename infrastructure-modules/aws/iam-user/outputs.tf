output "secret" {
  description = ""
  value       = aws_iam_access_key.default_access_key.secret
}
