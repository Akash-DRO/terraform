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

resource "aws_internet_gateway" "igw" {
   vpc_id = aws_vpc.main.id

   tags = {
      Name = "igw"
   }
}

resource "aws_eip" "eip" {
   vpc=true
}

resource "aws_nat_gateway" "ngw" {
   allocation_id = aws_eip.eip.id
   subnet_id = aws_subnet.subnet-p.id

   tags = {
      Name = "ngw"
   }
}

resource "aws_route_table" "public-route" {
   vpc_id = aws_vpc.main.id

   route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.igw.id
   }

#   route {
#   ipv6_cidr_block = "::/0"
#   egress_only_gateway_id = aws_egress_only_internet_gateway.igw.id
#   }

   tags = {
      Name = "public-route"
   }
}     

#resource "aws_default_route_table" "public-route-default" {
#   default_route_table_id = "aws_vpc.main.default_route_table_id"
#   
#   tags = {
#      Name = "public-route-default"
#   }
#}

resource "aws_route_table" "private-route" {
   vpc_id = aws_vpc.main.id

   route {
   cidr_block = "10.0.2.0/28"
   gateway_id = aws_nat_gateway.ngw.id
   }

#   route {
#   ipv6_cidr_block = "::/0"
#   egress_only_gateway_id = aws_egress_only_internet_gateway.igw.id
#   }

   tags = {
      Name = "private-route"
   }
}
