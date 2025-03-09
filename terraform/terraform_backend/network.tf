resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${var.prefix}-${terraform.workspace}-vpc"
  }
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "subnet_a" {
  count             = length(data.aws_availability_zones.available.names)
  vpc_id            = aws_vpc.name.id
  cidr_block        = "10.0.${count.index}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "${var.prefix}-${terraform.workspace}-subnet-${count.index}"
  }
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.name.id
  tags = {
    Name = "${var.prefix}-${terraform.workspace}-igw"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_vpc.name.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "a" {
  count          = length(data.aws_availability_zones.available.names)
  subnet_id      = aws_subnet.subnet_a[count.index].id
  route_table_id = aws_vpc.name.default_route_table_id
}