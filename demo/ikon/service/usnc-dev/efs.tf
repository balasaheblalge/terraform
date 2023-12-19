# IKON 
resource "aws_efs_file_system" "efs" {
  creation_token = "${var.resourceprefix}${var.efs_name}"
  depends_on     = [aws_security_group.ikon]
  encrypted      = true

  tags = merge({ "Name" = "${var.resourceprefix}${var.efs_name}_ikon" }, var.tags)
}

resource "aws_efs_mount_target" "efs_mnt" {

  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = data.terraform_remote_state.usnc-dev.outputs.subnet_ids[0]
  security_groups = [aws_security_group.efs.id]
}