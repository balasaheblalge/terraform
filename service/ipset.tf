# Creating the IP Set tp be defined in AWS WAF 
 
resource "aws_wafv2_ip_set" "cap_ipset" {
   name = "capgemini"
   scope = "REGIONAL"
   ip_address_version = "IPV4"
   addresses = var.capgemini_cidrs
   tags = merge({ "Name" = "${var.resourceprefix}_capgemini_ipset" }, var.tags)
}

resource "aws_wafv2_ip_set" "for_ipset" {
   name = "fortive"
   scope = "REGIONAL"
   ip_address_version = "IPV4"
   addresses = var.fortive_cidrs
   tags = merge({ "Name" = "${var.resourceprefix}_fortive_ipset" }, var.tags)
}

resource "aws_wafv2_ip_set" "eks_ipset" {
   name = "EKS"
   scope = "REGIONAL"
   ip_address_version = "IPV4"
   addresses = var.eks_cidrs
   tags = merge({ "Name" = "${var.resourceprefix}_eks_ipset" }, var.tags)
}

resource "aws_wafv2_ip_set" "awsvpn_ipset" {
   name = "awsvpn"
   scope = "REGIONAL"
   ip_address_version = "IPV4"
   addresses = var.awsvpn_cidrs
   tags = merge({ "Name" = "${var.resourceprefix}_awsvpn_ipset" }, var.tags)
}

resource "aws_wafv2_ip_set" "ipaas_ipset" {
   name = "ipaas"
   scope = "REGIONAL"
   ip_address_version = "IPV4"
   addresses = var.ipaas_cidrs
   tags = merge({ "Name" = "${var.resourceprefix}_ipaas_ipset" }, var.tags)
}
