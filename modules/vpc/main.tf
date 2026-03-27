# 1. VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = { Name = "vpc-${var.project_name}" }
}

# 2. Internet Gateway (A porta de entrada/saída)
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "igw-${var.project_name}" }
}

# 3. Subnets PÚBLICAS
resource "aws_subnet" "public" {
  count                   = 2
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index) # 10.0.0.0/24, 10.0.1.0/24
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true # Garante IP público para recursos aqui

tags = { 
    # Isso vai gerar algo como: subnet-public-1a-vendas-dev
    Name = "subnet-public-${substr(data.aws_availability_zones.available.names[count.index], -2, 2)}-${var.project_name}" 
  }
}

# 4. Tabela de Rotas Pública
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = { Name = "rt-public-${var.project_name}" }
}

# 5. Associação das Subnets Públicas com a Rota
resource "aws_route_table_association" "public" {
  count          = 2
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# 6. Subnets PRIVADAS (Para o Fargate / Cluster)
resource "aws_subnet" "private" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index + 10) # 10.0.10.0/24, 10.0.11.0/24
  availability_zone = data.aws_availability_zones.available.names[count.index]

tags = { 
    # Isso vai gerar algo como: subnet-private-1a-vendas-dev
    Name = "subnet-private-${substr(data.aws_availability_zones.available.names[count.index], -2, 2)}-${var.project_name}" 
  }
}

data "aws_availability_zones" "available" {}

# modules/vpc/main.tf

# Criar um IP Elástico (EIP) para CADA NAT Gateway
resource "aws_eip" "nat" {
  count  = 2
  domain = "vpc"
  tags   = { Name = "eip-nat-${substr(data.aws_availability_zones.available.names[count.index], -2, 2)}-${var.project_name}" }
}

# Criar o NAT Gateway em CADA Subnet PÚBLICA (1a e 1b)
resource "aws_nat_gateway" "main" {
  count         = 2
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  
  tags = { Name = "nat-${substr(data.aws_availability_zones.available.names[count.index], -2, 2)}-${var.project_name}" }

  depends_on = [aws_internet_gateway.gw]
}

# Criar uma Tabela de Rotas PRIVADA para CADA Zona
resource "aws_route_table" "private" {
  count  = 2
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[count.index].id
  }

  tags = { Name = "rt-private-${substr(data.aws_availability_zones.available.names[count.index], -2, 2)}-${var.project_name}" }
}

# Associar CADA Subnet Privada à sua respectiva Tabela de Rotas (AZ 1a com NAT 1a, etc)
resource "aws_route_table_association" "private" {
  count          = 2
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}