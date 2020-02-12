# Create a custom role for the lambda function
resource "aws_iam_role" "lambda" {
  name               = "lambda-basic-example"
  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
EOF

}

resource "aws_iam_role_policy_attachment" "lambda_role" {
  role       = aws_iam_role.lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

# Create the lambda function
module "custom_usage" {
  source = "../../"
  # source                 = "JousP/lambda-cloudwatch-alarm-to-slack/aws"
  # version                = "~> 2.0"
  function_name          = "cloudwatch-alarm-to-slack-custom"
  description            = "Push Cloudwatch Alarms Notifications to Slack"
  slack_webhook_url      = "https://hooks.slack.com/services/XXX/XXX/XXX"
  slack_channel          = "aws-notifications"
  slack_username         = "cloudwatch-alarm-to-slack-custom"
  log_events             = true
  create_role            = false
  role                   = aws_iam_role.lambda.arn
  vpc_config             = {
    subnet_ids           = [aws_subnet.aza.id, aws_subnet.azb.id]
    security_group_ids   = [aws_security_group.sg.id]
  }
  permission_principal   = "sns.amazonaws.com"
  function_tags          = {
    SNSTopic             = "MySNSTopic"
  }
}

output "role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the role."
  value       = module.custom_usage.role_arn
}

output "role_create_date" {
  description = "The creation date of the IAM role."
  value       = module.custom_usage.role_create_date
}

output "role_description" {
  description = "The description of the role."
  value       = module.custom_usage.role_description
}

output "role_id" {
  description = "The name of the role."
  value       = module.custom_usage.role_id
}

output "role_name" {
  description = "The name of the role."
  value       = module.custom_usage.role_name
}

output "role_unique_id" {
  description = "The stable and unique string identifying the role."
  value       = module.custom_usage.role_unique_id
}

output "function_file" {
  description = "The file containing the function source code"
  value       = module.custom_usage.function_file
}

output "function_archive" {
  description = "The archive containing the function files"
  value       = module.custom_usage.function_archive
}

output "function_arn" {
  description = "The Amazon Resource Name (ARN) identifying your Lambda Function."
  value       = module.custom_usage.function_arn
}

output "function_qualified_arn" {
  description = "The Amazon Resource Name (ARN) identifying your Lambda Function Version (if versioning is enabled via publish = true)."
  value       = module.custom_usage.function_qualified_arn
}

output "function_invoke_arn" {
  description = "The ARN to be used for invoking Lambda Function from API Gateway to be used in aws_api_gateway_integration's uri"
  value       = module.custom_usage.function_invoke_arn
}

output "function_version" {
  description = "Latest published version of your Lambda Function."
  value       = module.custom_usage.function_version
}

output "function_last_modified" {
  description = "The date this resource was last modified."
  value       = module.custom_usage.function_last_modified
}

output "function_kms_key_arn" {
  description = "The date this resource was last modified."
  value       = module.custom_usage.function_kms_key_arn
}

output "function_source_code_hash" {
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file provided either via filename or s3_* parameters."
  value       = module.custom_usage.function_source_code_hash
}

output "function_source_code_size" {
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file provided either via filename or s3_* parameters."
  value       = module.custom_usage.function_source_code_size
}

output "function_alias_arn" {
  description = "The Amazon Resource Name (ARN) identifying the Lambda function alias."
  value       = module.custom_usage.function_alias_arn
}

output "function_log_group_arn" {
  description = "The Amazon Resource Name (ARN) specifying the log group for the lambda function."
  value       = module.custom_usage.function_log_group_arn
}

output "function_log_group_name" {
  description = "The Name of the log group for the lambda function."
  value       = module.custom_usage.function_log_group_name
}

output "function_log_group_retention_in_days" {
  description = "The number of days log events are retained in the log group for the lambda function."
  value       = module.custom_usage.function_log_group_retention_in_days
}

output "function_log_group_tags" {
  description = "Tags associated with the log group for the lambda function."
  value       = module.custom_usage.function_log_group_tags
}