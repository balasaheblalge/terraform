resource "aws_iam_role" "secrets_manager" {
  name = "${var.resourceprefix}eks-secretsmanager"

  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Principal : {
          Federated : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${var.eks_oidc}"
        },
        Action : "sts:AssumeRoleWithWebIdentity",
        Condition : {
          StringEquals : {
            "${var.eks_oidc}:sub" : "system:serviceaccount:utility:common-db"
          }
        }
      }
    ]
  })

  tags = merge({ "Name" = "${var.resourceprefix}eks-secretsmanager" }, var.tags)
}

resource "aws_iam_role" "ses_sendmail_role" {
  name = "{${var.resourceprefix}ses_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ses.amazonaws.com"
        }
      },
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          AWS = formatlist("arn:aws:iam::%s:${var.ses_role_name}", local.allowed_account_ids)
        }
      }
    ]
  })

  inline_policy {
    name = "ses-sendmail-inline-policy"
    policy = jsonencode({
      Version = "2012-10-17",
      Statement = [
        {
          Effect = "Allow",
          Action = [
            "ses:SendEmail",
            "ses:SendRawEmail"
          ],
          Resource = [aws_sesv2_email_identity.apim.arn,
                      aws_sesv2_configuration_set.apim_ses.arn]
        }
      ]
    })
  }
  lifecycle {create_before_destroy = true}
}
