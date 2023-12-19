resource "aws_kms_key_policy" "example_policy" {
  key_id = aws_kms_key.s3.id

  policy = jsonencode({
    Version = "2012-10-17",
    Id      = "key-default-1",
    Statement = [
      {
        Sid       = "Enable IAM User Permissions",
        Effect    = "Allow",
        Principal = {
          AWS = "arn:aws:iam::653007420939:root"
        },
        Action    = "kms:*",
        Resource  = "*"
      },
      {
        Sid       = "Enable IAM User Permissions1",
        Effect    = "Allow",
        Principal = {
          AWS = "arn:aws:iam::647725377658:root"
        },
        Action    = "kms:*",
        Resource  = "*"
      },
      {
        Sid       = "Enable IAM User Permissions1",
        Effect    = "Allow",
        Principal = {
          AWS = "arn:aws:iam::647725377658:root"
        },
        Action    = "kms:*",
        Resource  = "*"
      }
    ]
  })
}