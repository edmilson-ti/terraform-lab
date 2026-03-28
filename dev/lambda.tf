module "lambda_app_teste" {
  source        = "../modules/lambda"
  function_name = "minha-primeira-lambda"

  memory_size = 128
  timeout = 60
  
  environment_variables = {
    ENV = "dev"
  }
}