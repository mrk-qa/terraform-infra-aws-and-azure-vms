resource "aws_key_pair" "key" {
  key_name   = "aws-key"
  public_key = var.aws_key_pub
}

resource "aws_instance" "vm" {
  ami                         = "ami-0c7217cdde317cfec"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.key.key_name
  subnet_id                   = data.terraform_remote_state.network.outputs.subnet_id_aws
  vpc_security_group_ids      = [data.terraform_remote_state.network.outputs.security_group_id_aws]
  associate_public_ip_address = true

  user_data = file("./scripts/index.sh")

  tags = {
    Name = "vm-terraform"
  }
}