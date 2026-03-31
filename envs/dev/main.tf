provider "aws" {
  region = "eu-central-1"
}

locals {
  prefix = "falkovska-anastasiia-20-v2"
}

module "s3" {
  source      = "../../modules/s3"
  bucket_name = "lab4-falkovska-anastasiia-20-v2"
}

module "lambda" {
  source        = "../../modules/lambda"
  function_name = "${local.prefix}-lambda"
  source_file   = "${path.root}/../../src/app.py"
  bucket_name   = module.s3.bucket_name
}

module "api" {
  source               = "../../modules/api_gateway"
  api_name             = "${local.prefix}-api"
  lambda_invoke_arn    = module.lambda.invoke_arn
  lambda_function_name = module.lambda.function_name
}

module "eventbridge" {
  source     = "../../modules/eventbridge"
  lambda_arn = module.lambda.lambda_arn   # ✅ ОЦЕ ПРАВИЛЬНО
}

output "api_url" {
  value = module.api.api_endpoint
}