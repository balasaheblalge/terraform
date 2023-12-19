output "tgw_attachment_id" {
  value = aws_ec2_transit_gateway_vpc_attachment.this.id
}

output "vpc_id" {
  value = aws_vpc.this.id
}

output "vpc_cidr" {
  value = aws_vpc.this.cidr_block
}

output "subnet_ids" {
  value = aws_subnet.this.*.id
}

output "subnet_cidrs" {
  value = aws_subnet.this.*.cidr_block
}

output "default_vpc_sg_id" {
  value = aws_vpc.this.default_security_group_id
}
