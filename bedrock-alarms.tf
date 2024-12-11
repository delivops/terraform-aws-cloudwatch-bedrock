resource "aws_cloudwatch_metric_alarm" "bedrock_high_invocations_alarm" {
  count               = var.invocation_count_enabled ? 1 : 0
  alarm_name          = "Bedrock | ${var.model_id} | High Invocations"
  alarm_description   = "High invocations in ${var.model_id}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "Invocations"
  namespace           = "AWS/Bedrock"
  period              = "3600"
  statistic           = "Average"
  threshold           = var.invocation_count
  alarm_actions       = var.aws_sns_topics_arns
  ok_actions          = var.aws_sns_topics_arns
  dimensions = {
    ModelId = var.model_id
  }
  tags = merge(var.tags, {
    "Terraform" = "true"
  })
}


resource "aws_cloudwatch_metric_alarm" "bedrock_client_error_rate_alarm" {
  count               = var.invocation_client_error_rate_enabled ? 1 : 0
  alarm_name          = "Bedrock | ${var.model_id} | High Error Rate Client"
  alarm_description   = "Client Error rate in ${var.model_id}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  threshold           = var.invocation_sever_error_rate
  alarm_actions       = var.aws_sns_topics_arns
  ok_actions          = var.aws_sns_topics_arns
  tags = merge(var.tags, {
    "Terraform" = "true"
  })
  metric_query {
    id          = "e1"
    expression  = "(FILL(m2,0))/FILL(m1,1)*100"
    label       = "client Error Rate"
    return_data = true

  }

  metric_query {
    id = "m1"
    metric {
      metric_name = "Invocations"
      namespace   = "AWS/Bedrock"
      period      = 3600
      stat        = "Sum"
      unit        = "Count"
      dimensions = {
        ModelId = var.model_id
      }

    }
  }
  metric_query {
    id = "m2"
    metric {
      metric_name = "InvocationClientErrors"
      namespace   = "AWS/Bedrock"
      period      = 3600
      stat        = "Sum"
      unit        = "Count"
      dimensions = {
        ModelId = var.model_id
      }
    }
  }
}


resource "aws_cloudwatch_metric_alarm" "bedrock_server_error_rate_alarm" {
  count               = var.invocation_server_error_rate_enabled ? 1 : 0
  alarm_name          = "Bedrock | ${var.model_id} | High Error Rate Server"
  alarm_description   = "Server Error rate in ${var.model_id}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  threshold           = var.invocation_sever_error_rate
  alarm_actions       = var.aws_sns_topics_arns
  ok_actions          = var.aws_sns_topics_arns
  tags = merge(var.tags, {
    "Terraform" = "true"
  })
  metric_query {
    id          = "e1"
    expression  = "(FILL(m2,0))/FILL(m1,1)*100"
    label       = "server Error Rate"
    return_data = true

  }

  metric_query {
    id = "m1"
    metric {
      metric_name = "Invocations"
      namespace   = "AWS/Bedrock"
      period      = 3600
      stat        = "Sum"
      unit        = "Count"
      dimensions = {
        ModelId = var.model_id
      }

    }
  }
  metric_query {
    id = "m2"
    metric {
      metric_name = "InvocationServerErrors"
      namespace   = "AWS/Bedrock"
      period      = 3600
      stat        = "Sum"
      unit        = "Count"
      dimensions = {
        ModelId = var.model_id
      }
    }
  }
}
