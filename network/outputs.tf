output "tgw_attachment_id" {
  value = aws_ec2_transit_gateway_vpc_attachment.this.id
}

output "vpc_id" {
  value = aws_vpc.this.id
}

output "vpc_cidr" {
  value = aws_vpc.this.cidr_block
}

output "subnet_ids_pri" {
  value = aws_subnet.private.*.id
}

output "subnet_cidrs_pri" {
  value = aws_subnet.private.*.cidr_block
}

output "subnet_ids_pub" {
  value = aws_subnet.public.*.id
}

output "subnet_cidrs_pub" {
  value = aws_subnet.public.*.cidr_block
}

output "default_vpc_sg_id" {
  value = aws_vpc.this.default_security_group_id
}
