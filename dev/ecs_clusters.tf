# cluster.tf

# 1. Definição do Cluster
resource "aws_ecs_cluster" "ecs_cluster_vendas" {
  name = "cluster-vendas-${var.environment}"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name        = "ecs-cluster-vendas-${var.environment}"
    Environment = var.environment
  }
}

# 2. Configuração de Capacidade (Onde as tarefas rodam)
resource "aws_ecs_cluster_capacity_providers" "vendas_capacity" {
  cluster_name = aws_ecs_cluster.ecs_cluster_vendas.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE" # Em dev, você pode mudar para FARGATE_SPOT para economizar
  }
}

# 3. Output do ID do Cluster (Importante para os seus Services)
output "ecs_cluster_id" {
  value       = aws_ecs_cluster.ecs_cluster_vendas.id
  description = "ID do Cluster ECS para ser usado nos serviços"
}