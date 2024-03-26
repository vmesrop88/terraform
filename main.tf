 
provider "aws" {
  region = "us-east-2"  
}



resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "example" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = "10.0.1.0/24"   
  availability_zone = "us-east-2a"   
}


resource "aws_instance" "example" {
  count         = var.instance_count
  ami           = "ami-019f9b3318b7155c5"  
  instance_type = "t3.micro"
  user_data     = <<-EOF
                  #!/bin/bash
                  echo "Hello from instance ${count.index + 1}" > /tmp/welcome.txt
                  EOF

  tags = {
    Name = format(var.instance_name_format, count.index + 1)
  }
}

output "private_ip_addresses" {
  value = aws_instance.example.*.private_ip
}