provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "demo-server" {
  ami = "ami-0dbc3d7bc646e8516"
  instance_type = "t2.micro"
  key_name = "course2"
}