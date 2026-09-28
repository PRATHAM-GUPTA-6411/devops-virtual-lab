provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "devops_sg" {
  name        = "devops-lab-sg"
  description = "Security group for DevOps lab"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Docker application"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "devops_server" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  key_name      = "vockey"

  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  tags = {
    Name = "DevOps-Lab-Server"
  }
}
