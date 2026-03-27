terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1" # Coloque a sua região aqui
}

# Defina aqui os nomes das suas aplicações
variable "app_names" {
  type    = list(string)
  default = ["repo-worker-vendas-dev", "repo-api-vendas-dev", "repo-frontend-vendas-dev"] 
}

resource "aws_ecr_repository" "apps" {
  for_each             = toset(var.app_names)
  name                 = each.value
  image_tag_mutability = "MUTABLE"

  # Limpeza automática: Mantém apenas as últimas 5 imagens para economizar espaço
  force_delete = true 

  image_scanning_configuration {
    scan_on_push = true # Boa prática: Escaneia vulnerabilidades no upload
  }

  tags = {
    Projeto  = "Vendas"
    Ambiente = "dev"
  }
}

# Output para você copiar a URL e fazer o Docker Push
output "ecr_repository_urls" {
  value = { for k, v in aws_ecr_repository.apps : k => v.repository_url }
}

# Busca os dados da conta onde você está autenticado
data "aws_caller_identity" "current" {}

# Exibe o ID da conta no final do terraform plan/apply
output "account_id" {
  value       = data.aws_caller_identity.current.account_id
  description = "ID da conta AWS onde os recursos serão criados"
}