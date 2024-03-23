
provider "aws" {
  region = "us-east-2"
}

resource "aws_dynamodb_table" "terraform_lock" {
  name           = "TfTable"
  hash_key       = "LockID"
  
  attribute {
    name = "LockID"
    type = "S"
  }

  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
}

terraform {
  backend "s3" {
    bucket         = "mesropv2024"
    key            = "terraform/state"
    region         = "us-east-2"
    encrypt        = true
    dynamodb_table = "TfTable"
  }
}

resource "aws_instance" "my_ec2" {
  count         = 3
  ami           = "ami-0e0bf53f6def86294" 
  instance_type = "t2.micro"
  tags = {
    Name = "MyEc2-${count.index + 1}"
  }
}
