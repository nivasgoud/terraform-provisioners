resource "aws_instance" "roboshop" {
  ami           = var.ami
  instance_type = var.inst_type
  subnet_id     = var.subnet
  vpc_security_group_ids = [aws_security_group.Roboshop_provisioner_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = var.name
  }

  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"   #self = aws_instance.roboshop
  }

  provisioner "local-exec" {
    command = "echo local-exec is nothing but the provisioner we are running in our local systems where our terraform is running"   
  }

  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip} > inventory.ini "    #self = aws_instance.roboshop
  }

  connection {
    type     = "ssh"
    user     = "centos"
    password = "DevOps321"
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    
    inline = [ "echo This is executing in remote server > /tmp/inventory.txt",
    
    " sudo yum install nginx -y",
    " sudo systemctl start nginx"]
  }

}



resource "aws_security_group" "Roboshop_provisioner_sg" {
  name        = "Roboshop_provisioner_sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = var.roboshop_vpc

  tags = {
    Name = "Roboshop_provisioner_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_443" {
  security_group_id = aws_security_group.Roboshop_provisioner_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_22" {
  security_group_id = aws_security_group.Roboshop_provisioner_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_80" {
  security_group_id = aws_security_group.Roboshop_provisioner_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.Roboshop_provisioner_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

