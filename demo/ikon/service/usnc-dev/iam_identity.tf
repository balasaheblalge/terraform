resource "aws_iam_openid_connect_provider" "eks" {
  url = "https://${var.tooling_eks_oidc}"

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = [
    data.tls_certificate.tooling_eks_oidc.certificates[0].sha1_fingerprint
  ]

  tags = merge({ "Name" = "${var.resourceprefix}jenkins-ssh" }, var.tags)
}