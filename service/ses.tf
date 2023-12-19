locals {
  allowed_account_ids = concat([data.aws_caller_identity.current.account_id], [var.allowed_account_ids])
}


resource "aws_sesv2_configuration_set" "apim_ses" {
  configuration_set_name = "apim-ses-configuration-set"

  delivery_options {
    tls_policy = "OPTIONAL"
  }

  reputation_options {
    reputation_metrics_enabled = false
  }

  sending_options {
    sending_enabled = true
  }
  tags = merge({ "Name" = "${var.resourceprefix}apim-config-set" }, var.tags)  
}

resource "aws_sesv2_email_identity" "apim" {
  email_identity         = var.email_identity
  configuration_set_name = aws_sesv2_configuration_set.apim_ses.configuration_set_name
  tags = merge({ "Name" = "${var.resourceprefix}apim-identity" }, var.tags)
}
