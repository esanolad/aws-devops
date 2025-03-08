

resource "aws_instance" "my_instance1" {

  count = length(data.aws_subnets.default_subnets.ids)

  #ami = "ami-0a474b3a85d51a5e5"
  ami = "ami-0e1bed4f06a3b463d"
  # subnet_id = data.aws_subnet.default_subnets.id
  # subnet_id = data.aws_subnets.default_subnets.ids[2]
  subnet_id              = data.aws_subnets.default_subnets.ids[count.index]
  vpc_security_group_ids = [aws_security_group.http_security_group.id]
  instance_type          = "t2.micro"
  user_data              = file("userdata.tpl")
  tags = {
    Name = "Dev-${count.index}"
  }
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt install apache2 -y",
      "cd /var/www/html/",
      "sudo rm -rf *",
      "sudo git clone https://github.com/esanolad/rccgmesssiah_website.git ."
    ]
  }
}

# resource "aws_instance" "my_instance2" {
#   ami = "ami-0a474b3a85d51a5e5"
# #   subnet_id = data.aws_subnet.default_subnets.id
#   subnet_id = data.aws_subnets.default_subnets.ids[1]
#   vpc_security_group_ids = [aws_security_group.http_security_group.id]
#   instance_type = "t2.micro"
#   user_data = file("userdata.tpl")
#   tags = {
#     Name = "dev-1"
#   }
#   connection {
#     type = "ssh"
#     host = self.public_ip
#     user = "ubuntu"
#     private_key = file("~/.ssh/id_rsa")
#   }
# }