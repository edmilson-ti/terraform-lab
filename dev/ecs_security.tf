# Cria um unico security group para o cluster ECS, que sera associado a todas as tarefas e servicos.

resource "aws_security_group" "ecs_sg_alltasks" {
  name        = "sgp-ecs-default-alltasks"
  description = "Acesso total via Fortinet - Inspecao centralizada"
  vpc_id      = module.vpc.vpc_id

# Libera todo trafego de entrada no security group, pois o trafego sera inspecionado e filtrado pelo Fortinet.
ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    security_groups = [aws_security_group.alb_sg.id]
  }

# Libera todo trafego de saida no security group, pois o trafego sera inspecionado e filtrado pelo Fortinet.
egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "ecs-sg-vendas-alltasks${var.environment}" }
}
