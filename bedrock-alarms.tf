resource "aws_cloudwatch_metric_alarm" "bedrock_high_invocations_alarm" {
  count                     = var.invocation_count_enabled ? 1 : 0
  alarm_name                = "Bedrock | High Invocations (>${var.invocation_count}) | ${var.model_id}"
  alarm_description         = "High invocations in ${var.model_id}"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
  metric_name               = "Invocations"
  namespace                 = "AWS/Bedrock"
  period                    = 300
  statistic                 = "Sum"
  threshold                 = var.invocation_count
  treat_missing_data        = "breaching"
  alarm_actions             = concat(var.all_alarms_sns_arns, var.invocation_sns_arns)
  ok_actions                = concat(var.all_alarms_sns_arns, var.invocation_sns_arns)
  insufficient_data_actions = concat(var.all_alarms_sns_arns, var.invocation_sns_arns)
  dimensions = {
    ModelId = var.model_id
  }
  tags = merge(var.tags, {
    "Terraform" = "true"
  })
}

resource "aws_cloudwatch_metric_alarm" "bedrock_high_input_tokens_alarm" {
  count                     = var.input_tokens_count_enabled ? 1 : 0
  alarm_name                = "Bedrock | High Input tokens (>${var.input_tokens_count}) | ${var.model_id}"
  alarm_description         = "High input tokens in ${var.model_id}"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
  metric_name               = "InputTokenCount"
  namespace                 = "AWS/Bedrock"
  period                    = 300
  statistic                 = "Average"
  threshold                 = var.input_tokens_count
  treat_missing_data        = "breaching"
  alarm_actions             = concat(var.all_alarms_sns_arns, var.input_tokens_sns_arns)
  ok_actions                = concat(var.all_alarms_sns_arns, var.input_tokens_sns_arns)
  insufficient_data_actions = concat(var.all_alarms_sns_arns, var.input_tokens_sns_arns)

  dimensions = {
    ModelId = var.model_id
  }
  tags = merge(var.tags, {
    "Terraform" = "true"
  })
}

resource "aws_cloudwatch_metric_alarm" "bedrock_client_error_rate_alarm" {
  count                     = var.invocation_client_error_rate_enabled ? 1 : 0
  alarm_name                = "Bedrock | High Error Rate Client (>${var.invocation_client_error_rate}%) | ${var.model_id}"
  alarm_description         = "Client Error rate in ${var.model_id}"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 12
  datapoints_to_alarm       = 8
  threshold                 = var.invocation_server_error_rate
  treat_missing_data        = "breaching"
  alarm_actions             = concat(var.all_alarms_sns_arns, var.invocation_client_error_rate_sns_arns)
  ok_actions                = concat(var.all_alarms_sns_arns, var.invocation_client_error_rate_sns_arns)
  insufficient_data_actions = concat(var.all_alarms_sns_arns, var.invocation_client_error_rate_sns_arns)
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
      period      = 300
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
      period      = 300
      stat        = "Sum"
      unit        = "Count"
      dimensions = {
        ModelId = var.model_id
      }
    }
  }
}


resource "aws_cloudwatch_metric_alarm" "bedrock_server_error_rate_alarm" {
  count                     = var.invocation_server_error_rate_enabled ? 1 : 0
  alarm_name                = "Bedrock | High Error Rate Server (>${var.invocation_server_error_rate}%) | ${var.model_id}"
  alarm_description         = "Server Error rate in ${var.model_id}"
  comparison_operator       = "GreaterThanThreshold"
  threshold                 = var.invocation_server_error_rate
  evaluation_periods        = 12
  datapoints_to_alarm       = 8
  treat_missing_data        = "breaching"
  alarm_actions             = concat(var.all_alarms_sns_arns, var.invocation_server_error_rate_sns_arns)
  ok_actions                = concat(var.all_alarms_sns_arns, var.invocation_server_error_rate_sns_arns)
  insufficient_data_actions = concat(var.all_alarms_sns_arns, var.invocation_server_error_rate_sns_arns)
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
      period      = 300
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
      period      = 300
      stat        = "Sum"
      unit        = "Count"
      dimensions = {
        ModelId = var.model_id
      }
    }
  }
}
