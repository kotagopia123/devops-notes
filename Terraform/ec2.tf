resource "aws_instance" "web" {
  
  ami           = var.ami-id
  instance_type = var.type-of-instance
  user_data     = <<-EOF
                    #!/bin/bash
                    yum update -y
                    yum install -y httpd
                    systemctl start httpd.service
                    systemctl enable httpd.service
                    EC2_AVAIL_ZONE=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
                    echo "<h1>Hello World from $(hostname -f) in AZ $EC2_AVAIL_ZONE </h1>" > /var/www/html/index.html
                  EOF

  vpc_security_group_ids = [aws_security_group.webserver-sg.id]
  key_name      = "myec2"
  tags = {
    Name = "WebServer"
  }
}

resource "aws_security_group" "webserver-sg" {
  name        = "webserver-sg"
  description = "Allow Traffic for SSH and Http"
  
  ingress {
    description      = "Http server"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]    
  }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]    
  }

  tags = {
    Name = "Webserver SG"
  }
}
