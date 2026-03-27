output "task_role_arn" {
  value       = aws_iam_role.ecs_task_role.arn
  description = "ARN da Role da Task. Use isso no seu services.tf para anexar políticas de S3, OCI, etc."
}

output "task_role_name" {
  value       = aws_iam_role.ecs_task_role.name
  description = "Nome da Role da Task (util para o recurso aws_iam_role_policy_attachment)"
}

output "service_name" {
  value       = aws_ecs_service.this.name
  description = "O nome do serviço ECS criado"
}

output "log_group_name" {
  value       = aws_cloudwatch_log_group.ecs_log_group.name
  description = "O nome do grupo de logs no CloudWatch"
}