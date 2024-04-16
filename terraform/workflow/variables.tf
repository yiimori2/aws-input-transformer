data "aws_caller_identity" "current" {}

variable "eventbridge_state" {
  type        = string
  default     = "ENABLED"
  description = "ステートマシンの起動の有効/無効"
}

variable "eventbridge_schedule_expression" {
  type        = string
  default     = "cron(00 10 * * ? *)" # 19:00 JST
  description = "ステートマシンの起動時刻"
}
