provider "aws" {
   region   = "us-east-2"
}
resource "aws_vpc" "main" {
   cider_block = "0.0.0.0/0"
   instance_tennancy = "default"

   tags = {
      Name = "main"
   }
}
