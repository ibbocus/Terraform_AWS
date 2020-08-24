provider "aws" {
    region = "${var.AWS_REGION}"
}

resource "aws_vpc" "prod-vpc" {
    cidr_block = "121.12.0.0/16"
    enable_dns_support = "true" #gives you an internal domain name
    enable_dns_hostnames = "true" #gives you an internal host name
    enable_classiclink = "false"
    instance_tenancy = "default"

    tags = {
        Name = "Eng67.Ibrahim.B.VPC.Terraform"
    }
}

resource "aws_subnet" "public-subnet" {
    vpc_id = "${aws_vpc.prod-vpc.id}"
    cidr_block = "121.12.10.0/24"
    map_public_ip_on_launch = "true" //it makes this a public subnet
    availability_zone = var.availability_zone
    tags = {
        Name = "Eng67.Ibrahim.Public.Subnet.Terraform"
    }
}

resource "aws_subnet" "private-subnet" {
    vpc_id = "${aws_vpc.prod-vpc.id}"
    cidr_block = "121.12.20.0/24"
    map_public_ip_on_launch = "false" //it makes this a public subnet
    availability_zone = var.availability_zone
    tags = {
        Name = "Eng67.Ibrahim.Private.Subnet.Terraform"
    }
}

resource "aws_network_acl" "public-nacl" {
  vpc_id = aws_vpc.prod-vpc.id
  subnet_ids = [aws_subnet.public-subnet.id]
  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }


  ingress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 130
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 140
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  tags = {
    Name = "Eng67.Ibrahim.Public.NACL.Terraform"
  }
}


resource "aws_network_acl" "private-nacl" {
  vpc_id = aws_vpc.prod-vpc.id
  subnet_ids = [aws_subnet.private-subnet.id]
  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "121.12.20.0/24"
    from_port  = 27017
    to_port    = 27017
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 140
    action     = "allow"
    cidr_block = "121.11.1.0/24"
    from_port  = 22
    to_port    = 22
  }


  ingress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  tags = {
    Name = "Eng67.Ibrahim.Private.NACL.Terraform"
  }
}



resource "aws_instance" "App_instance" {
          ami          = var.App_AMI
          instance_type = var.instance_type
          associate_public_ip_address = true
          vpc_security_group_ids = [var.App_sg]
          subnet_id = aws_subnet.public-subnet.id
          key_name = "DevOpsStudents"
          tags = {
              Name = "Eng67.Ibrahim.App.Terraform"
          }
}

resource "aws_instance" "DB_instance" {
          ami          = var.DB_AMI
          instance_type = var.instance_type
          associate_public_ip_address = true
          vpc_security_group_ids = [var.DB_sg]
          subnet_id = aws_subnet.private-subnet.id
          key_name = "DevOpsStudents"
          tags = {
              Name = "Eng67.Ibrahim.DB.Terraform"
          }
}

resource "aws_instance" "Bastion_instance" {
          ami          = var.Bastion_AMI
          instance_type = var.instance_type
          associate_public_ip_address = true
          vpc_security_group_ids = [var.Bastion_sg]
          subnet_id = aws_subnet.public-subnet.id
          key_name = "DevOpsStudents"
          tags = {
              Name = "Eng67.Ibrahim.Bastion.Terraform"
          }
}
