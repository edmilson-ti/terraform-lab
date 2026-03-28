output "lambda_arn" {
  description = "O ARN da função Lambda"
  value       = aws_lambda_function.lambda_function.arn
}

output "lambda_name" {
  description = "O nome da função Lambda"
  value       = aws_lambda_function.lambda_function.function_name
}

output "role_arn" {
  description = "O ARN da Role do IAM criada para a Lambda"
  value       = aws_iam_role.role_lambda.arn
}

output "log_group_name" {
  description = "O nome do grupo de logs no CloudWatch"
  value       = aws_cloudwatch_log_group.lambda_log_group.name
}