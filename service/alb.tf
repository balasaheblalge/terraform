#get route53 info
data "aws_route53_zone" "apim-zone" {
  name         = var.route53_apim_zone_name
  private_zone = false
}
resource "aws_route53_record" "apim" {
  zone_id = data.aws_route53_zone.apim-zone.zone_id
  name    = var.apim_fqdn
  type    = "A"

  alias {
    name                   = aws_lb.apim.dns_name
    zone_id                = aws_lb.apim.zone_id
    evaluate_target_health = false
  }
}


resource "aws_acm_certificate" "apim" {
  domain_name       = var.apim_fqdn
  validation_method = "DNS"
  tags              = merge({ "Name" = "${var.resourceprefix}acm-cert" }, var.tags)
}

resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.apim.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.apim-zone.zone_id
}

resource "aws_lb" "apim" {
  name               = "${var.resourceprefix}apim-alb"
  internal           = false
  load_balancer_type = "application"
  idle_timeout       = 360
  subnets            = data.terraform_remote_state.apim-network.outputs.subnet_ids_pub
  security_groups    = [aws_security_group.apim_alb.id]
  tags               = merge({ "Name" = "${var.resourceprefix}apim-alb" }, var.tags)
  access_logs {
    bucket  = module.lblogbucket.s3_bucket_id
    prefix  = "nadev"
    enabled = true
  }
}

resource "aws_lb_listener" "apim" {
  load_balancer_arn = aws_lb.apim.arn
  port              = var.apim_port
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = aws_acm_certificate.apim.arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      status_code  = 200
    }
  }
}

resource "aws_lb_listener_rule" "apim" {
  listener_arn = aws_lb_listener.apim.arn
  priority     = 50

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.apim.arn
  }

  condition {
    host_header {
      values = [var.apim_fqdn]
    }
  }
}

resource "aws_lb_target_group" "apim" {
  name        = "${var.resourceprefix}apim-tg"
  port        = var.apim_port
  protocol    = "HTTPS"
  target_type = "ip"
  vpc_id      = data.terraform_remote_state.apim-network.outputs.vpc_id

  health_check {
    path     = "/healthz"
    protocol = "HTTPS"
  }
  tags = merge(var.tags)
}

data "aws_network_interface" "apim_pl_interface" {
  count = length(data.terraform_remote_state.apim-network.outputs.subnet_ids_pub)
  id    = sort(aws_vpc_endpoint.apim_pl.network_interface_ids)[count.index]
}

resource "aws_lb_target_group_attachment" "apim" {
  count = length(data.terraform_remote_state.apim-network.outputs.subnet_ids_pri)

  target_group_arn = aws_lb_target_group.apim.arn
  target_id        = data.aws_network_interface.apim_pl_interface[count.index].private_ip
}

/*resource "aws_wafv2_web_acl_association" "apim" {
  resource_arn = aws_lb.apim.arn
  web_acl_arn  = aws_wafv2_web_acl.this.arn
}
*/
