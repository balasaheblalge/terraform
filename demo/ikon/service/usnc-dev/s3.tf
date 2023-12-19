resource "aws_kms_key" "s3" {
  description             = "KMS key is used to encrypt bucket objects"
  deletion_window_in_days = 7

  tags = merge({ "Name" = "${var.resourceprefix}ssm-s3" }, var.tags)
}

# module "s3" {
#   source        = "terraform-aws-modules/s3-bucket/aws"
#   version       = "3.4.0"
#   create_bucket = true

#   bucket = "${var.resourceprefix}ssm-s3"
#   versioning = {
#     enabled = false
#   }

#   server_side_encryption_configuration = {
#     rule = {
#       apply_server_side_encryption_by_default = {
#         kms_master_key_id = aws_kms_key.s3.arn
#         sse_algorithm     = "aws:kms"
#       }
#     }
#   }

#   tags = merge({ "Name" = "${var.resourceprefix}ssm-s3" }, var.tags)

# }

resource "aws_kms_key" "s3-ikon" {
  description             = "KMS key is used to encrypt bucket objects"
  deletion_window_in_days = 7

  tags = merge({ "Name" = "${var.resourceprefix}s3" }, var.tags)
}

module "s3" {
  source        = "terraform-aws-modules/s3-bucket/aws"
  version       = "3.4.0"
  create_bucket = true

  bucket = "ikon-file-share-nadev"
#  acl    = "private"

  # S3 bucket-level Public Access Block configuration
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  versioning = {
    enabled = false
  }

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = aws_kms_key.s3.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  tags = merge({ "Name" = "${var.resourceprefix}s3" }, var.tags)

}


resource "aws_kms_key" "s3-azureawsmigrate" {
  description             = "KMS key is used to encrypt bucket objects"
  deletion_window_in_days = 7

  tags = merge({ "Name" = "${var.resourceprefix}s3" }, var.tags)
}

module "s3awsazuremigrate" {
  source        = "terraform-aws-modules/s3-bucket/aws"
  version       = "3.4.0"
  create_bucket = true

  bucket = "azureawsmigrate-test"
#  acl    = "private"

  # S3 bucket-level Public Access Block configuration
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  versioning = {
    enabled = false
  }

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = aws_kms_key.s3.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  tags = merge({ "Name" = "${var.resourceprefix}s3" }, var.tags)

}