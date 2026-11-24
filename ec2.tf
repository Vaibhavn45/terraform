
provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "myec2" {
  ami                    = var.myami
  instance_type          = var.instance_type 
  key_name               = "id_rsa"
  vpc_security_group_ids = ["sg-07f20ea18fe5f6290"]

  tags = {
    Name    = "myec2"
    Env     = "dev"
    Project = "spider"
  }
}
variable "myami " {
default = "ami-01e4a7224fcbfe81f"
description = "this is us-east-2 ami"
}
variable "instance_type" {
default = "t3.micro"
description = "this is us-east-2 ami"
}