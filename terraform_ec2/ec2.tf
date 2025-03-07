

resource "aws_instance" "my_instance" {
  ami = "ami-0a474b3a85d51a5e5"
#   subnet_id = aws_subnet.aws_subnet_2.id
  vpc_security_group_ids = [aws_security_group.http_security_group.id]
  instance_type = "t2.micro"
  user_data = file("userdata.tpl")
  
  connection {
    type = "ssh"
    host = self.public_ip
    user = "ubuntu"
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