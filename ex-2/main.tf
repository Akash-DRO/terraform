provider "aws" {
   region   = "us-east-2"
}
resource "aws_vpc" "main" {
   cidr_block = "10.0.0.0/24"
   instance_tenancy = "default"
   
   tags = {
      Name = "main"
   }
}

resource "aws_subnet" "subnet-p" {
   vpc_id = "${aws_vpc.main.id}"
   cidr_block = "10.0.0.0/24"
     
   tags = {
      Name = "subnet-p"
   }
}
