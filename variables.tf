variable "invocation_count" {
  description = "Number of times to invoke the function"
  type        = number
  default     = 1

}

variable "invocation_count_enabled" {
  description = "Enable or disable the invocation of the function"
  type        = bool
  default     = true

}

variable "invocation_sever_error_rate" {
  description = "Error rate for the invocation of the function"
  type        = number
  default     = 10.0
}
variable "invocation_server_error_rate_enabled" {
  description = "Enable or disable the invocation of the function"
  type        = bool
  default     = true

}
variable "invocation_client_error_rate" {
  description = "Error rate for the invocation of the function"
  type        = number
  default     = 10.0

}
variable "invocation_client_error_rate_enabled" {
  description = "Enable or disable the invocation of the function"
  type        = bool
  default     = true

}

variable "model_id" {
  description = "Name of the model"
  type        = string
  default     = "model"

}

variable "aws_sns_topics_arns" {
  description = "List of ARNs for the SNS topics"
  type        = list(string)
  default     = []

}

variable "tags" {
  description = "Tags for the resources"
  type        = map(string)
  default     = {}

}
