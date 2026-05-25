provider "aws" {
  region = "us-east-1"
}

locals {
  instance_ids = [
    "i-0bd598f697c7fc624",
    "i-056c8143652b5f0b1"
  ]
}

resource "aws_ec2_instance_state" "ec2_state" {
  for_each = toset(local.instance_ids)

  instance_id = each.value
  state       = "running"   // Change to "stopped" to stop the instances
}