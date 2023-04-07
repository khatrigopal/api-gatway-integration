variable "api_name" {
  type        = string
  description = "The name of the API Gateway"
}

variable "description" {
  type        = string
  description = "The description of the API Gateway"
}

variable "resources" {
  type        = map(object({
    #parent_id = string
    #resource_name = string
    path_part = string
  }))
  description = "The resourcess to create for the API Gateway"
}

variable "methods" {
  type        = map(object({
    resource_name = string
    http_method   = string
    authorization = string
  }))
  description = "The HTTP methods to create for the API Gateway resources"
}

 variable "integration" {
   type        = map(object({
     resource_name = string
     http_method   = string
     integration_http_method = string
     lambda_function_arn = string
   }))
   description = "The HTTP methods to create for the API Gateway resources"
 }

variable "lambda_permission" {
  type        = map(object({
     lambda_function_name = string
     http_method   = string
     resource_name = string
   }))
   description = "The HTTP methods to create for the API Gateway resources"
 }
