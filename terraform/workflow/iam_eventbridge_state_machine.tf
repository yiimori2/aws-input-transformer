data "aws_iam_policy_document" "eventbridge_state_machine_iam_role_document" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eventbridge_state_machine_iam_role" {
  name               = "eventbridge-state-machine-input-transformer"
  assume_role_policy = data.aws_iam_policy_document.eventbridge_state_machine_iam_role_document.json
}

data "aws_iam_policy_document" "eventbridge_state_machine_iam_policy_document" {
  statement {
    effect    = "Allow"
    actions   = ["states:StartExecution"]
    resources = [aws_sfn_state_machine.state_machine_input_transformer.arn]
  }
}

resource "aws_iam_policy" "eventbridge_state_machine_iam_policy" {
  name   = "eventbridge-state-machine-input-transformer"
  policy = data.aws_iam_policy_document.eventbridge_state_machine_iam_policy_document.json
}

resource "aws_iam_policy_attachment" "eventbridge_state_machine_role_policy" {
  name       = "eventbridge-state-machine-input-transformer-policy-attachment"
  roles      = [aws_iam_role.eventbridge_state_machine_iam_role.name]
  policy_arn = aws_iam_policy.eventbridge_state_machine_iam_policy.arn
}
