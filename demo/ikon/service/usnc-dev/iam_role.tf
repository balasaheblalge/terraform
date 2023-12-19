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

resource "aws_iam_role" "jenkins_ssh_access" {
  name = "${var.resourceprefix}jenkins-ssh-access"

  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Principal : {
          Federated : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${var.tooling_eks_oidc}"
        },
        Action : "sts:AssumeRoleWithWebIdentity",
        Condition : {
          StringEquals : {
            "${var.tooling_eks_oidc}:sub" : "system:serviceaccount:gadm-jenkins:ikon-na-dev-ssh"
          }
        }
      }
    ]
  })

  tags = merge({ "Name" = "${var.resourceprefix}jenkins-ssh-access" }, var.tags)
}