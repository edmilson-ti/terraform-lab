# dev/alb_security.tf

resource "aws_security_group" "alb_sg" {
  name        = "alb-sg-vendas"
  description = "Permite acesso HTTP publico ao balanceador"
  vpc_id      = module.vpc.vpc_id

  # Entrada: HTTP vindo de qualquer lugar
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Saída: Liberada para o ALB enviar o tráfego para os containers
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "alb-sg-vendas" }
}