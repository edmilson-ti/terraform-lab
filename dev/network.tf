module "vpc" {
  source = "../modules/vpc"
  project_name = "vendas-vpc-${var.environment}"
  vpc_cidr = "10.0.0.0/16" 
}

