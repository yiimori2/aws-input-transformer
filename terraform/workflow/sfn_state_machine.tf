resource "aws_sfn_state_machine" "state_machine_input_transformer" {
  name     = "input-transformer"
  role_arn = aws_iam_role.state_machine_input_transformer_iam_role.arn
  definition = jsonencode(yamldecode(templatefile("${path.module}/templates/state_machine/input_transformer.asl.yaml", {
    aws_account_id = data.aws_caller_identity.current.account_id
    }
    )
  ))
}
