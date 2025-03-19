  provider "aws"  {
  region = "us-east-1"
  }
  
  resource "aws_instance"  "one" {
  ami      = "ami-04aa00acb1165b32a"
  instance_type = "t2.micro"
  key_name      = "fk-pub.pem"
  vpc_security_group_ids  = [aws_security_group.five.id]
  availability_zone = "us-east-1a"
  user_data         = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "Hi This is Faisal Project" > /var/www/html/index.html

EOF
  tags = {
    Name = "web-server-1"
    }
  }
  
  
  resource "aws_instance"  "two" {
  ami      = "ami-04aa00acb1165b32a"
  instance_type = "t2.micro"
  key_name      = "fk-pub.pem"
  vpc_security_group_ids  = [aws_security_group.five.id]
  availability_zone = "us-east-1b"
  tags = {
    Name = "web-server-2"
    }
  }
  
  resource "aws_instance"  "three" {
  ami      = "ami-04aa00acb1165b32a"
  instance_type = "t2.micro"
  key_name      = "fk-pub.pem"
  vpc_security_group_ids  = [aws_security_group.five.id]
  availability_zone = "us-east-1a"
  tags = {
    Name = "app-server-1"
    }
  }
  
  resource "aws_instance"  "four" {
  ami      = "ami-04aa00acb1165b32a"
  instance_type = "t2.micro"
  key_name      = "fk-pub.pem"
  vpc_security_group_ids  = [aws_security_group.five.id]
  availability_zone = "us-east-1b"
  tags = {
    Name = "app-server-2"
    }
  }
  
  resource "aws_security_group" "five" {
    name = "elb-sg"
    ingress {
      from_port    = 22
      to_port      = 22
      protocol     = "tcp"
      cidr_blocks  = ["0.0.0.0/0"]
  }
  
      ingress {
      from_port    = 22
      to_port      = 22
      protocol     = "tcp"
      cidr_blocks  = ["0.0.0.0/0"]
  }
  
      egress {
      from_port    = 0
      to_port      = 0
      protocol     = "-1"
      cidr_blocks  = ["0.0.0.0/0"]
  }
 }
 
 resource "aws_s3_bucket" "six" {
   bucket = "devopsbyfaisalkorejo045"
 }
 
 resource "aws_iam_user" "seven" {
 for_each = var.user_name
 name = each.value
 }
 
 variable "user_name" {
 description = ""
 type = set{string}
 default = ["user1", "user2"]
 
 resource "aws_ebs_volume" "eight" {
 availability_zone = "us-east-1a"
 size = 40
 tags = {
   Name = "ebs-001"
  }
}
  
    
    
  
  
  
  

