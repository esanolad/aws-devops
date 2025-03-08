# resource "aws_vpc" "my_aws_vpc" {
#   cidr_block = "10.10.0.0/16"
#   tags = {
#     Name = "sol_vpc"
#   }
# }
# resource "aws_subnet" "aws_subnet_0" {
#   vpc_id = aws_vpc.my_aws_vpc.id
#   cidr_block = "10.10.0.0/24"

# }
# resource "aws_subnet" "aws_subnet_1" {
#   vpc_id = aws_vpc.my_aws_vpc.id
#   cidr_block = "10.10.1.0/24"

# }
# resource "aws_subnet" "aws_subnet_2" {
#   vpc_id = aws_vpc.my_aws_vpc.id
#   cidr_block = "10.10.2.0/24"

# }

resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "http_security_group" {
  name = "tf_http_sg"
  # vpc_id = aws_vpc.my_aws_vpc.id
  vpc_id = aws_default_vpc.default.id
  ingress {
    from_port   = 80
    to_port     = 80
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
resource "aws_security_group" "elb_security_group" {
  name = "tf_elb_sg"
  # vpc_id = aws_vpc.my_aws_vpc.id
  vpc_id = aws_default_vpc.default.id
  ingress {
    from_port   = 80
    to_port     = 80
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