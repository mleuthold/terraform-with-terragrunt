output "ecr_arn" {
  description = ""
  value       = aws_ecr_repository.ecr_repo.arn
}

output "ecr_registry_id" {
  description = ""
  value       = aws_ecr_repository.ecr_repo.registry_id
}

output "ecr_registry_url" {
  description = ""
  value       = aws_ecr_repository.ecr_repo.repository_url
}
