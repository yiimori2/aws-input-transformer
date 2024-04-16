data "aws_iam_policy_document" "state_machine_input_transformer_iam_role_document" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["states.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "state_machine_input_transformer_iam_role" {
  name               = "state-machine-input-transformer"
  assume_role_policy = data.aws_iam_policy_document.state_machine_input_transformer_iam_role_document.json
}

data "aws_iam_policy_document" "state_machine_input_transformer_iam_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "states:ListExecutions"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "state_machine_input_transformer_iam_policy" {
  name   = "state-machine-input-transformer"
  policy = data.aws_iam_policy_document.state_machine_input_transformer_iam_policy_document.json
}

resource "aws_iam_policy_attachment" "state_input_transformer_role_policy" {
  name       = "state-machine-input-transformer-policy-attachment"
  roles      = [aws_iam_role.state_machine_input_transformer_iam_role.name]
  policy_arn = aws_iam_policy.state_machine_input_transformer_iam_policy.arn
}
