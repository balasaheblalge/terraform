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
  subnet_id     = data.terraform_remote_state.usnc-dev.outputs.subnet_ids[0]
#  key_name      = aws_key_pair.ec2_key.key_name
  vpc_security_group_ids = [
    aws_security_group.ikon.id,
    # module.sg_ccp_linux.sg_linux_id
  ]
  associate_public_ip_address = false
  get_password_data           = false
  iam_instance_profile        = data.aws_iam_instance_profile.session-manager-profile.name

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

# ikontest
resource "aws_instance" "ikontest" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.large"
  subnet_id     = data.terraform_remote_state.usnc-dev.outputs.subnet_ids[0]
  user_data = <<EOF
  #!/usr/bin/env bash
  sudo yum update -y
  sudo yum install git -y
  sudo yum install python3 python3-pip -y
  python3 -m venv /opt/ikon_ml/natools-ikon
  cd /opt/ikon_ml/natools-ikon/
  source /opt/ikon_ml/natools-ikon/bin activate
  /opt/ikon_ml/natools-ikon/bin/pip3 install azure-common==1.1.28 azure-core==1.22.1 azure-identity==1.8.0 azure-keyvault-secrets==4.3.0 Cython==0.29.27 fasttext-wheel==0.9.2 nltk==3.4.5 stop-words==2018.7.23 pandas==1.2.1 psycopg2-binary==2.9.3 scikit-learn==1.0.2 sklearn==0.0 scipy==1.7.3 SQLAlchemy==1.3.9 truecase==0.0.5 simplemma==0.5.0 pycountry==22.1.10 gensim==3.8.3 openpyxl==3.0.7 sparse-dot-topn
  EOF

  vpc_security_group_ids = [
    aws_security_group.ikon.id,
    # module.sg_ccp_linux.sg_linux_id
  ]
  associate_public_ip_address = false
  get_password_data           = false
  iam_instance_profile        = data.aws_iam_instance_profile.session-manager-profile.name

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

# Volume increasing to 50GB

resource "aws_ebs_volume" "ikon" {
  availability_zone = "us-east-1a"
  size              = 50
}
resource "null_resource" "restart-instance" {
  provisioner "local-exec" {
    command = "aws ec2 reboot-instances --instance-ids i-0b83e0f3ea37b6b61"
  }
}
resource "null_resource" "restart-instance1" {
  provisioner "local-exec" {
    command = "aws ec2 reboot-instances --instance-ids i-08138e232c831596b"
  }
}