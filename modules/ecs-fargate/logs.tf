resource "aws_cloudwatch_log_group" "ecs_log_group" {
  # O caminho padrão para logs de ECS
  name              = "/aws/ecs/${var.app_name}"
  
  # Importante para o seu Laboratório: 7 dias evita custos de storage desnecessários
  retention_in_days = 7

  tags = {
    Name        = "${var.app_name}-logs"
    Environment = "dev"
  }
}