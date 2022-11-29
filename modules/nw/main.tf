
data "aws_availability_zones" "available" {
  state = "available"
}


//vpc create
resource "aws_vpc" "my-vpc001" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = "true"


  tags = {
    Name = "${terraform.workspace}-dev-vpc"
    env = terraform.workspace
  }
}

 //route table for pub-snet
resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.my-vpc001.id

  
tags = {
    Name = "${terraform.workspace}-pub-route001"
  env = terraform.workspace
  }
}


# //creation igw
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc001.id

  tags = {
    Name = "${terraform.workspace}-igw001"
    env = terraform.workspace
  }
}
# # //igw association with pub-route-table
resource "aws_route" "igw001" {
    route_table_id = aws_route_table.pub-rt.id
    destination_cidr_block = var.all_traffic_allow
    gateway_id = aws_internet_gateway.my-igw.id
  
}

// subnet ceration using for each loop

resource "aws_subnet" "pub-subnet" {
  for_each = var.pub-snets
  map_public_ip_on_launch = "true"
 availability_zone  = each.value["availability_zone"]
  cidr_block = each.value["cidr_block"]
  vpc_id     = aws_vpc.my-vpc001.id

  tags = {
    Name = "${terraform.workspace}-pub-snets"
  }
}
//private subnet
# resource "aws_subnet" "pri-subnet" {
#   for_each = var.pri-snets
#  availability_zone  = each.value["availability_zone"]
#   cidr_block = each.value["cidr_block"]
#   vpc_id     = aws_vpc.my-vpc001.id

#   tags = {
#     Name = "${terraform.workspace}-pri-snets"
#   }
# }
//route table association
resource "aws_route_table_association" "pub-ass" {
    for_each = aws_subnet.pub-subnet
   subnet_id      = each.value.id
   route_table_id = aws_route_table.pub-rt.id
 }



