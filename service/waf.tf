resource "aws_wafv2_web_acl" "this" {
  name        = "${var.resourceprefix}waf"
  description = "WAF for Application Load Balancers"
  scope       = "REGIONAL"

  default_action {
    block {}
  }

  rule {
    name     = "capgemini-ip-allow"
    priority = 0

    action {
      allow {}
    }
    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.cap_ipset.arn
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "${var.resourceprefix}waf-ip-allow"
      sampled_requests_enabled   = false
    }
  }

  rule {
    name     = "eks-ip-allow"
    priority = 1

    action {
      allow {}
    }
    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.eks_ipset.arn
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "${var.resourceprefix}waf-ip-allow"
      sampled_requests_enabled   = false
    }
  }

  rule {
    name     = "awsvpn-ip-allow"
    priority = 2

    action {
      allow {}
    }
    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.awsvpn_ipset.arn
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "${var.resourceprefix}waf-ip-allow"
      sampled_requests_enabled   = false
    }
  }

  rule {
    name     = "ipaas-ip-allow"
    priority = 3

    action {
      allow {}
    }
    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.ipaas_ipset.arn
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "${var.resourceprefix}waf-ip-allow"
      sampled_requests_enabled   = false
    }
  }

  rule {
    name     = "forive-ip-allow"
    priority = 4

    action {
      allow {}
    }
    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.for_ipset.arn
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "${var.resourceprefix}waf-ip-allow"
      sampled_requests_enabled   = false
    }
  }

  rule {
    name     = "CoreRuleSet"
    priority = 5
    override_action {
      count {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "${var.resourceprefix}waf-CommonRuleSet"
      sampled_requests_enabled   = false
    }
  }
  rule {
    name     = "AdminProtection"
    priority = 6
    override_action {
      count {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAdminProtectionRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "${var.resourceprefix}waf-AdminProtectionRuleSet"
      sampled_requests_enabled   = false
    }
  }
  rule {
    name     = "KnownBadInputs"
    priority = 7
    override_action {
      count {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "${var.resourceprefix}waf-KnownBadInputsRuleSet"
      sampled_requests_enabled   = false
    }
  }
  rule {
    name     = "LinuxOperatingSystem"
    priority = 8
    override_action {
      count {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesLinuxRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "${var.resourceprefix}waf-LinuxRuleSet"
      sampled_requests_enabled   = false
    }
  }
  rule {
    name     = "AmazonIPReputationList"
    priority = 9
    override_action {
      count {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAmazonIpReputationList"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "${var.resourceprefix}waf-ReputationList"
      sampled_requests_enabled   = false
    }
  }
  rule {
    name     = "AnonymousIPList"
    priority = 10
    override_action {
      count {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAnonymousIpList"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "${var.resourceprefix}waf-AnonymousIpList"
      sampled_requests_enabled   = false
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "${var.resourceprefix}waf"
    sampled_requests_enabled   = false
  }

  tags = merge({ "Name" = "${var.resourceprefix}waf" }, var.tags)

}
