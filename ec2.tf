
provider "aws" {
    region = "us-est-2"
}
resource " aws_instance" "myec2" {
ami = "ami-01e4a7224fcbfe81f"
instance_type ="t3.micro"
key_name = "id_rsa"
vpc_security_group_ids =[sg-07f20ea18fe5f6290]
tags = {
name = "myec2"
env ="dev"
Name ="spider
}
}