# Definição da Task (O que rodar)
resource "aws_ecs_task_definition" "this" {
  family                   = var.app_name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = aws_iam_role.ecs_exec_role.arn

  container_definitions = jsonencode([{
    name  = var.app_name
    image = var.container_image
    portMappings = [{
      containerPort = var.container_port
      hostPort      = var.container_port
    }]
  }])
}

# O Serviço (Como manter rodando)
resource "aws_ecs_service" "this" {
  name            = var.app_name
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = var.target_group_arn # O ARN do TG que criamos no alb.tf
    container_name   = var.app_name          # Deve ser IGUAL ao nome no container_definitions
    container_port   = var.container_port   # A porta onde a app roda (ex: 80)
  }

  network_configuration {
    subnets         = var.private_subnets
    security_groups = [var.security_group_id]
  }
}