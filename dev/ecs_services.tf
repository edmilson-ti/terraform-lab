# Api de vendas - Fargate Service
module "ecs_svc_api_vendas" {
  source = "../modules/ecs-fargate"

  # Identificação
  app_name = "svc-api-vendas"

  # Infraestrutura (Referências ao que você já criou no dev/)
  cluster_id        = aws_ecs_cluster.ecs_cluster_vendas.id           # ARN do seu Cluster
  vpc_id            = module.vpc.vpc_id                      # Sua VPC de Lab
  private_subnets   = module.vpc.private_subnet_ids              # Onde o Fargate vai "morar"
  security_group_id = aws_security_group.ecs_sg_alltasks.id # O SG que você corrigiu!

  # Configuração do Container
  target_group_arn = aws_lb_target_group.vendas_tg.arn # O Target Group que você corrigiu!
  container_image = "nginx:latest" # Imagem de exemplo, substitua pela sua
  container_port  = 80 # A porta que você corrigiu no main.tf do módulo

  # Dimensionamento (Sem default, você define aqui)
  cpu           = 256  # 0.25 vCPU
  memory        = 512  # 512MB RAM
  desired_count = 2    # 2 instâncias rodando
}

# Worker de processamento - Fargate Service
module "ecs_svc_worker_vendas" {
  source = "../modules/ecs-fargate"

  # Identificação
  app_name = "svc-worker-vendas"

  # Infraestrutura (Referências ao que você já criou no dev/)
  cluster_id = aws_ecs_cluster.ecs_cluster_vendas.id           # ARN do seu Cluster
  vpc_id = module.vpc.vpc_id                      # Sua VPC de Lab
  private_subnets = module.vpc.private_subnet_ids              # Onde o Fargate vai "morar"
  security_group_id = aws_security_group.ecs_sg_alltasks.id # O SG que você corrigiu!

# Configuração do Container
  target_group_arn = aws_lb_target_group.vendas_tg.arn
  container_image = "nginx:latest" # Imagem de exemplo, substitua pela sua
  container_port  = 80 # A porta que você corrigiu no main.tf do módulo

  # Dimensionamento (Sem default, você define aqui)
  cpu           = 256  # 0.25 vCPU
  memory        = 512  # 512MB RAM
  desired_count = 2    # 2 instâncias rodando
}