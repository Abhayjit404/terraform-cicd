resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    instance_tenancy = "default"

    tags = {
        Name = "my_vpc"
    }
}
resource "aws_subnet" "public-1" {
    vpc_id = "${aws_vpc.my_vpc.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"

    tags = {
        Name = "public-1"
    }
}
resource "aws_subnet" "private-1" {
    vpc_id = "${aws_vpc.my_vpc.id}"
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1a"

    tags = {
        Name = "private-1"
    }
}
resource "aws_internet_gateway" "my_igw" {
    vpc_id = "${aws_vpc.my_vpc.id}"

    tags =  {
        Name = "my_igw"
    }
}
resource "aws_route_table" "public-rt" {
    vpc_id = "${aws_vpc.my_vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.my_igw.id}"
    }

    tags = {
        Name = "public-rt"
    }
}
resource "aws_route_table_association" "public-rt" {
    subnet_id = "${aws_subnet.public-1.id}"
    route_table_id = "${aws_route_table.public-rt.id}"
}
