resource "aws_cloudwatch_event_rule" "state_machine_event_rule" {
  name                = "eventbridge-workflow-input-transformer"
  schedule_expression = var.eventbridge_schedule_expression
  state               = var.eventbridge_state
}

resource "aws_cloudwatch_event_target" "state_machine_event_target" {
  rule     = aws_cloudwatch_event_rule.state_machine_event_rule.name
  arn      = aws_sfn_state_machine.state_machine_input_transformer.arn
  role_arn = aws_iam_role.eventbridge_state_machine_iam_role.arn
  input_transformer {
    input_paths = {
      "date" : "$.time"
    }
    input_template = <<EOF
    {
      "environments": {
        "date": "--date <date>",
        "ruleArn": <aws.events.rule-arn>,
        "ruleName": <aws.events.rule-name>,
        "integrationTime": <aws.events.event.ingestion-time>
      }
    }
    EOF
  }
}
