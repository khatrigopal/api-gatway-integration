# Resources
resource "aws_api_gateway_rest_api" "api_gateway" {
  name        = var.api_name
  description = "API Gateway for ${var.api_name}"
}



resource "aws_api_gateway_resource" "resource" {
  for_each = var.resources

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = each.value.path_part
}

resource "aws_api_gateway_method" "method" {
  for_each = var.methods

  rest_api_id       = aws_api_gateway_rest_api.api_gateway.id
  resource_id       = aws_api_gateway_resource.resource[each.value.resource_name].id
  http_method    = each.value.http_method
  authorization   = each.value.authorization
}

 resource "aws_api_gateway_integration" "integration" {
   for_each = var.integration

   rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
   resource_id             = aws_api_gateway_resource.resource[each.value.resource_name].id
   #http_method             = aws_api_gateway_method.method[each.value.http_method]
    http_method    = each.value.http_method
   integration_http_method = each.value.integration_http_method
   type                    = "AWS_PROXY"
   uri                     = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/${each.value.lambda_function_arn}/invocations"
 }

 resource "aws_lambda_permission" "allow_api" {
   for_each = var.lambda_permission 

   statement_id  = "AllowAPIgatewayInvokation"
   action        = "lambda:InvokeFunction"
   function_name =  each.value.lambda_function_name
   principal     = "apigateway.amazonaws.com"
   source_arn    = "arn:aws:execute-api:us-east-1:558940753150:${aws_api_gateway_rest_api.api_gateway.id}/*/${each.value.http_method}/${each.value.resource_name}"
}


 resource "aws_api_gateway_deployment" "deployment" {
   depends_on = [aws_api_gateway_integration.integration]
   
   for_each = var.deployment
   
   rest_api_id = aws_api_gateway_rest_api.api_gateway.id
   stage_name  = each.value.stage_name

   #triggers = {
    # redeployment = sha1(jsonencode(aws_api_gateway_rest_api.api_gateway.body))
   #}

   #depends_on = [aws_api_gateway_integration.integration]
   lifecycle {
     create_before_destroy = true
   }
 }

 #resource "aws_api_gateway_stage" "deploy" {
  # deployment_id = aws_api_gateway_deployment.deployment1.id
   # depends_on    = [aws_api_gateway_integration.integration]
   #rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
   #stage_name    = var.stage_name
   
#description   = "Deployment for ${var.api_name}"
# }




