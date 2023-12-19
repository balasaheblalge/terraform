resource "aws_iam_policy" "secrets_manager" {
  name = "${var.resourceprefix}eks-secretsmanager"

  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Action : "secretsmanager:ListSecrets",
        Resource : "*"
      },
      {
        Effect : "Allow",
        Action : "secretsmanager:*",
        Resource : [
          "arn:aws:secretsmanager:${var.region}:${data.aws_caller_identity.current.account_id}:secret:*"
        ]
      }
    ]
  })

  tags = merge({ "Name" = "${var.resourceprefix}eks-sm-policy" }, var.tags)
}

resource "aws_iam_policy" "session_manager_policy" {
  name = "${var.resourceprefix}session-manager-policy"

  policy = jsonencode({
    Version : "2012-10-17",
    "Statement": [
        {
            "Action": [
                "ssmmessages:OpenDataChannel",
                "ssmmessages:OpenControlChannel",
                "ssmmessages:CreateDataChannel",
                "ssmmessages:CreateControlChannel",
                "ssm:UpdateInstanceInformation"
            ],
            "Effect": "Allow",
            "Resource": "*",
            "Sid": ""
        },
        {
            "Action": [
                "logs:PutLogEvents",
                "logs:DescribeLogStreams",
                "logs:DescribeLogGroups",
                "logs:CreateLogStream"
            ],
            "Effect": "Allow",
            "Resource": "*",
            "Sid": ""
        },
        {
            "Action": "s3:PutObject",
            "Effect": "Allow",
            "Resource": "arn:aws:s3:::aws-accelerator-s3-access-logs-653007420939-us-east-1/*",
            "Sid": ""
        },
        {
            "Action": "s3:GetEncryptionConfiguration",
            "Effect": "Allow",
            "Resource": "*",
            "Sid": ""
        },
        {
            "Action": "kms:Decrypt",
            "Effect": "Allow",
            "Resource": "arn:aws:kms:us-east-1:653007420939:key/2c11ddcb-bc94-46ad-ae54-6954978d5717",
            "Sid": ""
        },
        {
            "Action": "kms:GenerateDataKey",
            "Effect": "Allow",
            "Resource": "*",
            "Sid": ""
        }
    ]
  })

  tags = merge({ "Name" = "${var.resourceprefix}jenkins-ssh-policy" }, var.tags)
}
resource "aws_iam_policy" "aws_session_manager_ssh_policy" {
  name = "${var.resourceprefix}aws_session_manager_ssh_policy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "ssm:StartSession",
            "Resource": [
                "arn:aws:kms:us-east-1:653007420939:instance/*",
                "arn:aws:ssm:*:*:document/AWS-StartSSHSession"
            ]
        }
    ]
  })

  tags = merge({ "Name" = "${var.resourceprefix}aws_session_manager_ssh_policy" }, var.tags)
}
resource "aws_iam_role_policy_attachment" "secrets_manager" {
  role       = aws_iam_role.secrets_manager.name
  policy_arn = aws_iam_policy.secrets_manager.arn
}
resource "aws_iam_role_policy_attachment" "jenkins-ssh" {
  role       = aws_iam_role.jenkins_ssh_access.name
  policy_arn = aws_iam_policy.aws_session_manager_ssh_policy.arn
}
resource "aws_iam_role_policy_attachment" "s3fullaccess" {
  role       = aws_iam_role.jenkins_ssh_access.name
  policy_arn = data.aws_iam_policy.s3fullaccess.arn
}
resource "aws_iam_role_policy_attachment" "aws-ssh" {
  role       = aws_iam_role.jenkins_ssh_access.name
  policy_arn = aws_iam_policy.session_manager_policy.arn
}
resource "aws_iam_role_policy_attachment" "cloudWatchagentserverpolicy" {
  role       = aws_iam_role.jenkins_ssh_access.name
  policy_arn = data.aws_iam_policy.cloudWatchagentserverpolicy.arn
}
resource "aws_iam_role_policy_attachment" "session-manager-policyy" {
  role       = aws_iam_role.jenkins_ssh_access.name
  policy_arn = data.aws_iam_policy.session-manager-policyy.arn
}
resource "aws_iam_role_policy_attachment" "amazonssmmanagedinstancecore" {
  role       = aws_iam_role.jenkins_ssh_access.name
  policy_arn = data.aws_iam_policy.amazonssmmanagedinstancecore.arn
}
resource "aws_iam_role_policy_attachment" "amazonssmdirectoryserviceaccess" {
  role       = aws_iam_role.jenkins_ssh_access.name
  policy_arn = data.aws_iam_policy.amazonssmdirectoryserviceaccess.arn
}
resource "aws_iam_role_policy_attachment" "amazonec2fullaccess" {
  role       = aws_iam_role.jenkins_ssh_access.name
  policy_arn = data.aws_iam_policy.ec2fullaccess.arn
}
resource "aws_iam_role_policy_attachment" "amazonssmfullaccess" {
  role       = aws_iam_role.jenkins_ssh_access.name
  policy_arn = data.aws_iam_policy.amazonssmfullaccess.arn
}
