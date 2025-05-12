
resource "aws_key_pair" "tp2_key" {
  key_name   = "tp2-keypair"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4098
}

resource "local_file" "tp2_keypair" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "${path.module}/tp1-keypair.pem"
}

resource "aws_instance" "web_server" {
  ami           = var.ami_id
  instance_type = var.instance_type

  subnet_id                   = aws_subnet.public_subnets[0].id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.https_access.id]

  key_name = aws_key_pair.tp2_key.key_name

  tags = {
    Name = "ep_instance"
  }

  root_block_device {
    volume_size = 30
  }

}
