variable "region" {
  type        = string
  description = "Região da AWS (ex: us-east-1)"
}

variable "environment" {
  type        = string
  description = "Nome do ambiente"
  # Você pode deixar sem default para o .tfvars preencher
}