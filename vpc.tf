
resource "aws_vpc" "myvpc" {
  cidr_block = local.vpc_cidr

  tags = {
    Name = "myvpc-${var.project_name}"
  }
}

resource "aws_subnet" "pvt-subnet" {
  cidr_block = local.pvt_sub_cidr
  vpc_id     = aws_vpc.myvpc.id

  tags = {
    Name = "pvt-subnet-${var.project_name}"
  }

  map_public_ip_on_launch = false
}

resource "aws_subnet" "pub-subnet" {
  cidr_block = local.pub_sub_cidr
  vpc_id     = aws_vpc.myvpc.id

  tags = {
    Name = "pub-subnet-${var.project_name}"
  }

  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "igw-${var.project_name}"
  }
}

resource "aws_route_table" "myroute" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = local.route
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "myroute-${var.project_name}"
  }
}

resource "aws_route_table_association" "route-connectivity" {
  subnet_id      = aws_subnet.pub-subnet.id
  route_table_id = aws_route_table.myroute.id
}
resource "aws_security_group" "my-sg" {
  name        = "my-ec2-sg"
  description = "Allow SSH access"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-ec2-sg"
  }
}
resource "aws_instance" "myec2" {
  ami                    = var.myami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.my-sg.id]
  subnet_id              = aws_subnet.pub-subnet.id

  tags = {
    Name = "myec2"
  }
}
