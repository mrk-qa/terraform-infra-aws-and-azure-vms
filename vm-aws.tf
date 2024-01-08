resource "aws_key_pair" "key" {
  key_name   = var.key_pair_name_aws
  public_key = var.aws_key_pub
}

resource "aws_instance" "vm" {
  ami                         = var.ami_aws
  instance_type               = var.instance_type_aws
  key_name                    = aws_key_pair.key.key_name
  subnet_id                   = data.terraform_remote_state.vpc.outputs.subnet_id_aws_full
  vpc_security_group_ids      = [data.terraform_remote_state.vpc.outputs.security_group_id_aws_full]
  associate_public_ip_address = true

  availability_zone = var.location_aws

  user_data = file("./scripts/index_aws.sh")

  tags = {
    Name = var.tag_id_aws
  }
}