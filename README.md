![image info](logo.jpeg)

# Terraform-aws-cloudwatch-bedrock

Terraform-aws-tg-monitor is a Terraform module for setting up a notification system about bedrock metrics.

## Installation

To use this module, you need to have Terraform installed. You can find installation instructions on the Terraform website.

## Usage

The module will create a notification system to alert when your bedrock model is unhealthy.
Use this module multiple times to create repositories with different configurations.

Include this repository as a module in your existing terraform code:

```python

################################################################################
# AWS BEDROCK
################################################################################

provider "aws" {
  region = "eu-west-1"
}

resource "aws_sns_topic" "sns_topic" {
  name         = "sns"
  display_name = "sns"
}

resource "aws_sns_topic_subscription" "sns_subscription" {
  confirmation_timeout_in_minutes = 1
  endpoint_auto_confirms          = false
  topic_arn                       = aws_sns_topic.sns_topic.arn
  protocol                        = "https"
  endpoint                        = "https://api.sns.com/v1/xxx"
  depends_on                      = [aws_sns_topic.sns_topic]
}

module "bedrock_alarms" {
  source = "delivops/bedrock-alerts/aws"
  #version            = "0.0.1"

  model_id            = "my_model_123"
  aws_sns_topics_arns = ["arn:aws:sns:xxx:cloudwatch-alarms"]

}

```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.67.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.67.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_metric_alarm.bedrock_client_error_rate_alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.bedrock_high_input_tokens_alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.bedrock_high_invocations_alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.bedrock_server_error_rate_alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_sns_topics_arns"></a> [aws\_sns\_topics\_arns](#input\_aws\_sns\_topics\_arns) | List of ARNs for the SNS topics | `list(string)` | `[]` | no |
| <a name="input_input_tokens_count"></a> [input\_tokens\_count](#input\_input\_tokens\_count) | Number of input tokens | `number` | `100` | no |
| <a name="input_input_tokens_count_enabled"></a> [input\_tokens\_count\_enabled](#input\_input\_tokens\_count\_enabled) | Enable or disable the invocation of the function | `bool` | `true` | no |
| <a name="input_invocation_client_error_rate"></a> [invocation\_client\_error\_rate](#input\_invocation\_client\_error\_rate) | Error rate for the invocation of the function | `number` | `10` | no |
| <a name="input_invocation_client_error_rate_enabled"></a> [invocation\_client\_error\_rate\_enabled](#input\_invocation\_client\_error\_rate\_enabled) | Enable or disable the invocation of the function | `bool` | `true` | no |
| <a name="input_invocation_count"></a> [invocation\_count](#input\_invocation\_count) | Number of times to invoke the function | `number` | `1` | no |
| <a name="input_invocation_count_enabled"></a> [invocation\_count\_enabled](#input\_invocation\_count\_enabled) | Enable or disable the invocation of the function | `bool` | `true` | no |
| <a name="input_invocation_server_error_rate_enabled"></a> [invocation\_server\_error\_rate\_enabled](#input\_invocation\_server\_error\_rate\_enabled) | Enable or disable the invocation of the function | `bool` | `true` | no |
| <a name="input_invocation_sever_error_rate"></a> [invocation\_sever\_error\_rate](#input\_invocation\_sever\_error\_rate) | Error rate for the invocation of the function | `number` | `10` | no |
| <a name="input_model_id"></a> [model\_id](#input\_model\_id) | Name of the model | `string` | `"model"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for the resources | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->