

resource "aws_instance" "my_instance" {

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
      "echo Welcome to webserver - Virtual Server is at ${self.public_dns} | sudo tee /var/www/html/index.html"
    ]
  }
}

resource "aws_lb" "my_alb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb_security_group.id]
  subnets            = data.aws_subnets.default_subnets.ids

  enable_deletion_protection = false
}
resource "aws_lb_target_group" "my_target_group" {
  name     = "my-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_default_vpc.default.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
  }
}


resource "aws_lb_target_group_attachment" "name" {
  count = length(data.aws_subnets.default_subnets.ids)
  target_group_arn = aws_lb_target_group.my_target_group.arn
  target_id = aws_instance.my_instance[count.index].id
  port = 80
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_target_group.arn
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