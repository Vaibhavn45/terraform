variable "myami " {
  default     = "ami-01e4a7224fcbfe81f"
  description = "this is us-east-2 ami"
}
variable "instance_type" {
  default     = "t3.micro"
  
}
variable "key_name" {
  default     = "id_rsa"
}
variable "mysg" {
  default     = "sg-07f20ea18fe5f6290"
  
}
variable "project_name" {
  default     = "myproject"
  
}
variable "region" {
  default     = "us-east-2"
  
}
locals {
  vpc_cidr = "10.0.0.0/16"
  pvt-sub-cidr = "10.0.1.0/24"
  pub-sub-cidr = "10.0.2.0/24"
  route = "0.0.0.0/0"
}
