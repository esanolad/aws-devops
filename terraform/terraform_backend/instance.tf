resource "aws_security_group" "http_ssh_security_group" {
  name   = "${var.prefix}-${terraform.workspace}-http_ssh_sg"
  vpc_id = aws_vpc.name.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "http_security_group" {
  name   = "${var.prefix}-${terraform.workspace}-http_sg"
  vpc_id = aws_vpc.name.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami = "ami-0e1bed4f06a3b463d"
  subnet_id              = aws_subnet.subnet_a[0].id
  vpc_security_group_ids = [aws_security_group.http_ssh_security_group.id]
  instance_type          = "t2.micro"
  user_data              = file("userdata.tpl")
  tags = {
    Name = "${var.prefix}-${terraform.workspace}-web"
  }
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
  }
}