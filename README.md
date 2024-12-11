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
