resource "aws_vpc" "myvpc" {
    cidr_block = local.vpc_cidr
    tags = {
        Name = "myvpc-${var.project_name}"
    }
}
resource "aws_subnet" "pvt-subnet" {
    cidr_block = "local.pvt-sub-cidr"
    vpc_id = "aws_vpc.myvpc.id"
    tags = {
        Name = "pvt-subnet-${var.project_name}"
    }
    map_public_ip_on_launch = false
}
resource "aws_subnet" "pub-subnet" {
    cidr_block = "local.pub-sub-cidr"
    vpc_id = "aws_vpc.myvpc.id"
    tags = {
        Name = "pub -subnet-${var.project_name}"
    }
    map_public_ip_on_launch = true
}
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "igw-${var.project_name}"
    }
}
resource "aws_route_table" "myroute" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "local.route"
        gateway_id = aws_internet_gateway.iw.id
    }
    tags = {
        Name = "myroute-${var.project_name}"
    }
}

resource "aws_route_table_association" "route-connectivity"{
subnet_id      = aws_subnet.pub-subnet.id
route_table_id = aws_route_table.myroute.id
}

resource "aws_instance" "myec2" {
    ami = var.myami
    instance_type = var.instance_type
    key_name = var.key_name
    vpc_security_group_ids = [var.mysg]
    subnet_id =aws_subnet.pub-subnet_id
}