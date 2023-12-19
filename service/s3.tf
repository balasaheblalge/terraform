resource "aws_kms_key" "s3" {
  description             = "KMS key is used to encrypt bucket objects"
  deletion_window_in_days = 7

  tags = merge({ "Name" = "${var.resourceprefix}s3" }, var.tags)
}
module "lblogbucket" {
  source        = "terraform-aws-modules/s3-bucket/aws"
  version       = "3.4.0"
  create_bucket = true

  bucket = "na-dev-lb-log-1"
#    acl  = "log-delivery-write"

# S3 bucket-level Public Access Block configuration
   block_public_acls       = true
   block_public_policy     = true
   ignore_public_acls      = true
   restrict_public_buckets = true
 
  versioning = {
    enabled = false
  }

#   server_side_encryption_configuration = {
#     rule = {
#       apply_server_side_encryption_by_default = {
#         kms_master_key_id = aws_kms_key.s3.arn
#         sse_algorithm     = "aws:kms"
#       }
#     }
#  }
  attach_elb_log_delivery_policy = true
  tags = merge({ "Name" = "${var.resourceprefix}s3" }, var.tags)
}
resource "aws_s3_bucket_policy" "lbaccess" {
  bucket = "na-dev-lb-log-1"
  policy = "${data.aws_iam_policy_document.s3_bucket_lb_write.json}"
}
data "aws_iam_policy_document" "s3_bucket_lb_write" {
  policy_id = "s3_bucket_lb_logs"

  statement {
    actions = [
      "s3:PutObject",
    ]
    effect = "Allow"
    resources = [
      "${module.lblogbucket.s3_bucket_arn}/*",
    ]

    principals {
      identifiers = ["${data.aws_elb_service_account.main.arn}"]
      type        = "AWS"
    }
  }

  statement {
    actions = [
      "s3:PutObject"
    ]
    effect = "Allow"
    resources = ["${module.lblogbucket.s3_bucket_arn}/*"]
    principals {
      identifiers = ["delivery.logs.amazonaws.com"]
      type        = "Service"
    }
  }
}