# dev/alb.tf

# O Load Balancer (Publico)
resource "aws_lb" "vendas_alb" {
  name               = "alb-vendas-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = module.vpc.public_subnet_ids # Usa as subnets 1a e 1b

  tags = { Name = "alb-vendas-${var.environment}" }
}

# O Target Group (Configurado para IP por causa do Fargate)
resource "aws_lb_target_group" "vendas_tg" {
  name        = "tg-vendas-${var.environment}"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id
  target_type = "ip" # Obrigatorio para modo awsvpc do Fargate

  health_check {
    path                = "/"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }
}

# O Listener (Encaminha o trafego da porta 80 para o Target Group)
resource "aws_lb_listener" "vendas_http" {
  load_balancer_arn = aws_lb.vendas_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.vendas_tg.arn
  }
}