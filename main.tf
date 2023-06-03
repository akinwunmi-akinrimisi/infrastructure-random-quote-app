provider "aws" {
  region = var.aws_region
}

data "aws_ssm_parameter" "instance_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

# Creating the VPC
resource "aws_vpc" "app_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "app_vpc"
  }
}

# Creating the Internet Gateway
resource "aws_internet_gateway" "app_igw" {
  vpc_id = aws_vpc.app_vpc.id
  tags = {
    Name = "app_igw"
  }
}

# Creating the public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.app_vpc.id
  cidr_block              = var.public_subnet_cidr_block
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = "app_public_subnet"
  }
}

# Creating the public route table
resource "aws_route_table" "project_public_rt" {
  vpc_id = aws_vpc.app_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.app_igw.id
  }
}


# Associating our public subnet with our public route table
resource "aws_route_table_association" "public" {
  route_table_id = aws_route_table.project_public_rt.id
  subnet_id      = aws_subnet.public_subnet.id
}


# Creating a security group for the Jenkins server
resource "aws_security_group" "app_sg" {
  name        = "app_sg"
  description = "Security group for app server"
  vpc_id      = aws_vpc.app_vpc.id

  ingress {
    description = "allow anyone on port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow anyone on port 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow anyone on port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "app_sg"
  }
}

# Creating an EC2 instance called app_server
resource "aws_instance" "app_server" {
  ami                    = data.aws_ssm_parameter.instance_ami.value
  subnet_id              = aws_subnet.public_subnet.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  key_name               = var.aws_key_pair
  /* count = 2 */
  user_data              = fileexists("install_app.sh") ? file("install_app.sh") : null
  tags = {
    Name = "app_server"
  }
}

# Creating an Elastic IP called jenkins_eip
/* resource "aws_eip" "jenkins_eip" {
  instance = aws_instance.app_server.id
  vpc      = true
  tags = {
    Name = "jenkins_eip"
  }
} */