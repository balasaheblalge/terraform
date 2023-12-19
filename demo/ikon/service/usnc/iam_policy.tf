resource "aws_iam_policy" "secrets_manager" {
  name        = "${var.resourceprefix}eks-secretsmanager"

  policy = jsonencode({
    Version: "2012-10-17",
    Statement: [
      {
        Effect: "Allow",
        Action: "secretsmanager:ListSecrets",
        Resource: "*"
      },
      {
        Effect: "Allow",
        Action: "secretsmanager:*",
        Resource: [
          "arn:aws:secretsmanager:${var.region}:${data.aws_caller_identity.current.account_id}:secret:*"
        ]
      }
    ]
  })

}

resource "aws_iam_role_policy_attachment" "secrets_manager" {
  role       = aws_iam_role.secrets_manager.name
  policy_arn = aws_iam_policy.secrets_manager.arn
}
