#get ipam info
data "aws_vpc_ipam_pool" "ikon-ipam" {
  filter {
    name   = "description"
    values = ["*gadm-ikon-sandpit*"]
  }

  filter {
    name   = "address-family"
    values = ["ipv4"]
  }
}

resource "aws_vpc" "this" {
  #  cidr_block                       = var.vpc_cidr
  ipv4_ipam_pool_id                = data.aws_vpc_ipam_pool.ikon-ipam.id
  ipv4_netmask_length              = 26
  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = false

  tags = merge({ "Name" = "${var.resourceprefix}${var.vpc_name}" }, var.tags)
}

# resource "aws_flow_log" "this" {
#   log_destination      = data.terraform_remote_state.sec_eu_data.outputs.vpcflowlog_bucket_arn
#   log_destination_type = "s3"
#   traffic_type         = "ALL"
#   vpc_id               = aws_vpc.this.id
#
#   tags = merge({ "Name" = "${var.resourceprefix}${var.vpcflowlog_name}" }, var.tags)
# }

# resource "aws_vpc_dhcp_options" "this" {
#   domain_name_servers  = "AmazonProvidedDNS"
#
#   tags = merge({ "Name" = "${var.resourceprefix}${var.dhcpoptions_name}" }, var.tags)
# }

# resource "aws_vpc_dhcp_options_association" "this" {
#   vpc_id          = aws_vpc.this.id
#   dhcp_options_id = aws_vpc_dhcp_options.this.id
# }

resource "aws_default_network_acl" "this" {
  default_network_acl_id = aws_vpc.this.default_network_acl_id

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  lifecycle {
    ignore_changes = [subnet_ids]
  }

  tags = merge({ "Name" = "${var.resourceprefix}${var.nacl_name}" }, var.tags)
}

resource "aws_route_table" "vpc" {
  vpc_id = aws_vpc.this.id

  tags = merge({ "Name" = "${var.resourceprefix}${var.rtb_vpc_name}" }, var.tags)
}

resource "aws_main_route_table_association" "this" {
  vpc_id         = aws_vpc.this.id
  route_table_id = aws_route_table.vpc.id
}
