provider "aws" {
  region = "us-east-1"

}

# Create two EC2 instances with Apache installed and a custom index.html page
resource "aws_instance" "linux1" {
  ami                    = "ami-0eb38b817b93460ac" #amazon Linux
  instance_type          = "t3.micro"
  key_name               = "terraform"
  vpc_security_group_ids = ["sg-0ccc0b6d549df6714"]

  user_data = <<-SCRIPT
                #!/bin/bash
                sudo yum update -y
                sudo yum install httpd -y
                sudo systemctl start httpd
                sudo systemctl enable httpd
                echo "Hello World from custom page-1" > /var/www/html/index.html 
                SCRIPT

  tags = {
    Name = "aws-linux1"
  }

}

# Create two EC2 instances with Apache installed and a custom index.html page
resource "aws_instance" "linux2" {
  ami                    = "ami-0eb38b817b93460ac" #amazon Linux
  instance_type          = "t3.micro"
  key_name               = "terraform"
  vpc_security_group_ids = ["sg-0ccc0b6d549df6714"]

  user_data = <<-SCRIPT
                #!/bin/bash
                sudo yum update -y
                sudo yum install httpd -y
                sudo systemctl start httpd                                              
                sudo systemctl enable httpd                                 
                echo "Hello World from custom page-2" > /var/www/html/index.html
                SCRIPT

  tags = {
    Name = "aws-linux2"
  }

}



#Public IP
output "server1_public_ip" {
  value = aws_instance.linux1.public_ip
}

output "server2_public_ip" {
  value = aws_instance.linux2.public_ip
}

# Instance ID
output "server1_instance_id" {
  value = aws_instance.linux1.id
}

  output "server2_instance_id" {
  value = aws_instance.linux2.id
}

# Public DNS
output "server1_public_dns" {
  value = aws_instance.linux1.public_dns
}

output "server2_public_dns" {
  value = aws_instance.linux2.public_dns
}

# Instance State
output "server1_instance_state" {
  value = aws_instance.linux1.instance_state
}

output "server2_instance_state" {
  value = aws_instance.linux2.instance_state
}






