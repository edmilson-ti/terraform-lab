variable "function_name" {
  description = "Nome da função Lambda"
  type        = string
}

variable "handler" {
  description = "Onde a execução começa (ex: index.handler)"
  type        = string
  default     = "index.handler"
}

variable "runtime" {
  description = "Runtime da linguagem"
  type        = string
  default     = "python3.13"
}

variable "memory_size" {
  type    = number
  default = 128
}

variable "timeout" {
  type    = number
  default = 30
}

variable "environment_variables" {
  type    = map(string)
  default = {}
}