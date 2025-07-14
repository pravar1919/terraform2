
provider "aws" {
    region =  "ap-south-1"
}

resource "aws_security_group" "ssh_only" {
  name = "ssh_only_nothing_else"

  description = "80, 22 and managed from terraform"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Open to the world (safe for public HTTP)
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "web" {
  ami           = "ami-0f918f7e67a3323f0"
  instance_type = "t3.micro"
  key_name = "gameground"

  vpc_security_group_ids = [aws_security_group.ssh_only.id]
  user_data = file("./script.sh")

  tags = {
    Name = "My another new instance"
  }
}

output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.web.public_ip
}
