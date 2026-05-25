provider "aws" {
  region = "us-east-1"
}

# Create Linux EC2 Instance
resource "aws_instance" "linux_server" {
  ami                    = "ami-0eb38b817b93460ac"
  instance_type          = "t3.micro"
  key_name               = "terraform"
  vpc_security_group_ids = ["sg-0445d5fec0ec86639"]

  user_data = <<-EOF
                #!/bin/bash
                yum update -y
                yum install httpd -y
                systemctl start httpd
                systemctl enable httpd
                echo "Hello from Terraform Linux Server3" > /var/www/html/index.html
                EOF

  tags = {
    Name = "linux-server"
  }
}

# Create and Attach Elastic IP
resource "aws_eip" "linux_eip" {
  instance = aws_instance.linux_server.id

  tags = {
    Name = "terraform-linux-eip"
  }
}

# Output Elastic IP
output "elastic_ip" {
  value = aws_eip.linux_eip.public_ip
}