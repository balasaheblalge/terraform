resource "aws_iam_openid_connect_provider" "eks" {
  url = "https://${var.eks_oidc}"

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = [
    data.tls_certificate.eks_oidc.certificates[0].sha1_fingerprint
  ]

  tags = merge({ "Name" = "${var.resourceprefix}eks-secretsmanager" }, var.tags)
}