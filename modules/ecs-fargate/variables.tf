# --- Identificação ---
variable "app_name" {
  type        = string
  description = "Nome da aplicação"
}

# --- Infraestrutura ---
variable "cluster_id" {
  type        = string
  description = "ID ou Nome do Cluster ECS"
}

variable "desired_count" {
  type        = number
  description = "Quantidade de instâncias a manter rodando"
}

# --- Configuração do Container ---
variable "container_image" {
  type        = string
  description = "URL da imagem no ECR"
}

variable "container_port" {
  type        = number
  description = "Porta que a aplicação escuta no container"
}

# --- Recursos (Dimensionamento) ---
variable "cpu" {
  type        = number
  description = "Unidades de CPU (ex: 256, 512, 1024)"
}

variable "memory" {
  type        = number
  description = "Memória em MB (ex: 512, 1024, 2048)"
}

# --- Rede e Segurança ---
variable "vpc_id" {
  type        = string
  description = "ID da VPC onde os recursos residem"
}

variable "private_subnets" {
  type        = list(string)
  description = "Lista de IDs das subnets privadas"
}

variable "security_group_id" {
  type        = string
  description = "ID do Security Group compartilhado (ex: o SG que permite tráfego do Fortinet)"
}

variable "target_group_arn" {
  type        = string
  description = "ARN do Target Group do ALB para o serviço ECS"
  
}