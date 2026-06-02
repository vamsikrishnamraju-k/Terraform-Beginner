provider "aws" {
  region = "us-east-1"

}

# Create two EC2 instances with Apache installed and a custom index.html page
resource "aws_instance" "linux1" {
  ami                    = "ami-0eb38b817b93460ac" #amazon Linux
  instance_type          = "t3.micro"
  key_name               = "terraform"
  vpc_security_group_ids = ["default"]

  user_data = file("user_data.sh")

  tags = {
    Name = "aws-linux1"
  }
}
