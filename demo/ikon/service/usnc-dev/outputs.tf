output "rds_endpoint" {
  value = aws_db_instance.postgresql.endpoint

}

output "ec2_name" {
  value = aws_instance.ikon.id
}

#output "ec2_private_key" {
#  value     = sensitive(tls_private_key.rsa_key.private_key_openssh)
#  sensitive = true
#}