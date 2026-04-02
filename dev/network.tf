module "vpc" {
  source = "../modules/vpc"
  project_name = "vendas-vpc"
  vpc_cidr = "10.0.0.0/16" 
}

