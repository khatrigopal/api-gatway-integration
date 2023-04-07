module "example_api_gateway" {
  source = "./modules/api_gateway"

  api_name        = "example-api"
  description = "Example API Gateway REST API"

  resources = {
    "resource1" = {
      #parent_id = aws_api_gateway_rest_api.example_api.root_resource1_id
      #resource_name = "resource1"
      #parent_id = "module.example_api_gateway.root_resource_id"
      path_part = "resource1"
    }
    "resource2" = {
      #parent_id = aws_api_gateway_resource.example_resource["resource1"].id
      #parent_id = aws_api_gateway_resource.example_api.root_resource2.id 
      #resource_name = "resource2"
      #parent_id = "module.example_api_gateway.root_resource_id"
      path_part = "resource2"
    }
  }

  methods = {
    "method1" = {
      resource_name = "resource1"
      http_method   = "POST"
      authorization = "NONE"
    }
    "method2" = {
      resource_name = "resource2"
      http_method   = "POST"
      authorization = "NONE"
    }
  }

  integration = {
    "integration1" = {
      resource_name = "resource1"
      http_method   = "POST"
      lambda_function_arn = "arn:aws:lambda:us-east-1:223522054519:function:test"
    }
    "integration2" = {
      resource_name = "resource2"
      http_method   = "POST"
      lambda_function_arn = "arn:aws:lambda:us-east-1:223522054519:function:batch-test"
    }
  } 

  lambda_permission = {
    "lambda_permission1" = {
      lambda_function_name = "test"
      resource_name = "resource1"
      http_method   = "POST"
    }
    "lambda_permission2" = {
      resource_name = "resource2"
      http_method   = "POST"
      lambda_function_name = "batch-test"
    }
  } 
}
