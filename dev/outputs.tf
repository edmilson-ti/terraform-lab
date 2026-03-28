output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnet_ids
}

output "private_subnets" {
  value = module.vpc.private_subnet_ids
}

output "lambda_arn" {
  value = module.lambda_app_teste.lambda_arn
}

output "lambda_name" {
  value = module.lambda_app_teste.lambda_name
}

output "role_arn" {
  value = module.lambda_app_teste.role_arn
}

output "log_group_name" {
  value = module.lambda_app_teste.log_group_name
}