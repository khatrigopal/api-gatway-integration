module "example_api_gateway" {
  source = "./modules/api-gateway"

  api_name        = "test-integration-api"
  description = "Example API Gateway REST API"

  resources = {
    "resource1" = {
      
      path_part = "resource1"
    }
    "resource2" = {
      
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
       integration_http_method = "POST"
       lambda_function_arn = "arn:aws:lambda:us-east-1:558940753150:function:test1"
     }
     "integration2" = {
       resource_name = "resource2"
       http_method   = "POST"
       integration_http_method = "POST"
       lambda_function_arn = "arn:aws:lambda:us-east-1:558940753150:function:test2"
     }
   } 

  lambda_permission = {
     "lambda_permission1" = {
       lambda_function_name = "test1"
       resource_name = "resource1"
       http_method   = "POST"
     }
     "lambda_permission2" = {
       resource_name = "resource2"
       http_method   = "POST"
       lambda_function_name = "test2"
     }
   } 
  
  deployment = {
    "test" = {
      stage_name = "dev"
    }
    "test2" = {
      stage_name = "prod"
    }
  }
}
