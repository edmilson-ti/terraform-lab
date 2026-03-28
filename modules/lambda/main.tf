# 1. Cria um arquivo "dummy" para a Lambda não nascer vazia
data "archive_file" "dummy" {
  type        = "zip"
  output_path = "${path.module}/dummy.zip"
  
  source {
    content  = "def handler(event, context): return {'statusCode': 200}"
    filename = "index.py"
  }
}

# 2. Role de Execução
resource "aws_iam_role" "role_lambda" {
  name = "${var.function_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

# 3. Permissões Básicas (Logs)
resource "aws_iam_role_policy_attachment" "role_lambda_policy" {
  role       = aws_iam_role.role_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# 4. Grupo de Logs com retenção
resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = 7
}

# 5. A Função Lambda
resource "aws_lambda_function" "lambda_function" {
  function_name = var.function_name
  role          = aws_iam_role.role_lambda.arn
  handler       = var.handler
  runtime       = var.runtime
  memory_size   = var.memory_size
  timeout       = var.timeout

  filename         = data.archive_file.dummy.output_path
  source_code_hash = data.archive_file.dummy.output_base64sha256

  environment {
    variables = var.environment_variables
  }

  # IMPORTANTE: Permite que você mude o código depois via Pipeline 
  # sem que o Terraform tente "voltar" para o código dummy.
  lifecycle {
    ignore_changes = [
      filename,
      source_code_hash
    ]
  }
}