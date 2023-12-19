# AMIs
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
    #["eaf-hardened-stig-low-*"]
  }
}

# ikon
resource "aws_instance" "ikon" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.ikon_type
  subnet_id     = data.terraform_remote_state.network_usnc.outputs.subnet_ids[0]
  key_name      = aws_key_pair.ec2_key.key_name
  vpc_security_group_ids = [
    aws_security_group.ikon.id,
   # module.sg_ccp_linux.sg_linux_id
  ]
  associate_public_ip_address = false
  get_password_data           = false
  iam_instance_profile        = aws_iam_instance_profile.ssmprofile.name

  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.ikon_volumesize
    delete_on_termination = true
  }

  disable_api_termination = false
  lifecycle {
    ignore_changes = [ebs_optimized, ami]
  }

  tags        = merge({ "Name" = join("", [var.ec2_name_region, var.platform_abbr, "ik", var.ec2_name_env, "01"]) }, var.tags)
  volume_tags = merge({ "Name" = join("", [var.ec2_name_region, var.platform_abbr, "ik", var.ec2_name_env, "01"]) }, var.tags)
}
