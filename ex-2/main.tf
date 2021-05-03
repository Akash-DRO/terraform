provider "aws" {
   region   = "us-east-2"
}
resource "aws_vpc" "main" {
   cidr_block = "10.0.0.0/20"
   instance_tenancy = "default"
   
   tags = {
      Name = "main"
   }
}

resource "aws_subnet" "subnet-p" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "10.0.1.0/28"
     
  tags = {
     Name = "subnet-p"
  }
}

resource "aws_subnet" "subnet-pi" {
   vpc_id = "${aws_vpc.main.id}"
   cidr_block = "10.0.2.0/28"

   tags = {
     Name= "subnet-pi"
   }
}
