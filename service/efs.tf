# APIM
resource "aws_efs_file_system" "efsapim" {
  creation_token = "${var.resourceprefix}${var.efs_name}"
  depends_on     = [aws_security_group.apim]
  encrypted      = true

  tags = merge({ "Name" = "${var.resourceprefix}${var.efs_name}_apim" }, var.tags)
}

resource "aws_efs_mount_target" "efs_mnt_apim1" {
  file_system_id  = aws_efs_file_system.efsapim.id
  subnet_id       = data.terraform_remote_state.apim-network.outputs.subnet_ids_pri[0]
  security_groups = [aws_security_group.efs.id]
}

resource "aws_efs_mount_target" "efs_mnt_apim2" {
  file_system_id  = aws_efs_file_system.efsapim.id
  subnet_id       = data.terraform_remote_state.apim-network.outputs.subnet_ids_pri[1]
  security_groups = [aws_security_group.efs.id]
}