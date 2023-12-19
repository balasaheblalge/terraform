resource "aws_iam_role" "ssmprofile" {
  name               = "${var.resourceprefix}ssmprofile"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = merge({ "Name" = "${var.resourceprefix}ssmprofile" }, var.tags)
}

resource "aws_iam_role_policy_attachment" "ssmpolicy" {
  for_each   = toset(var.ssm_policy)
  role       = aws_iam_role.ssmprofile.name
  policy_arn = each.value
}

resource "aws_iam_instance_profile" "ssmprofile" {
  name = "${var.resourceprefix}ssmprofile"
  role = aws_iam_role.ssmprofile.name
}
