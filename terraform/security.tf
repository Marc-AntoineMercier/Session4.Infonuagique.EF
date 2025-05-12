resource "aws_security_group" "https_access" {
  name        = "HTTPS"
  description = "Allow all tcp"
  vpc_id      = aws_vpc.epreuve_final.id

  ingress {

    description = "HTTPS"
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}