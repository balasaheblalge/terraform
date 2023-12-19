/*resource "tls_private_key" "rsa_key" {
  algorithm = "RSA"
}

resource "aws_key_pair" "ec2_key" {
  key_name   = "${var.resourceprefix}ec2-key1"
  public_key = tls_private_key.rsa_key.public_key_openssh
}
*/