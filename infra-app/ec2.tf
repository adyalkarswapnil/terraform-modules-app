# Key Pair
resource "aws_key_pair" "My_key" {
  key_name   = "${var.env}-infra-app-key"
  public_key = file("terra-key-ec2.pub")

tags = {
    Environment =var.env
}
}


# Default VPC
resource "aws_default_vpc" "default" {

}

# Security Group
resource "aws_security_group" "my_security_group" {
  name        = "${var.env}-infra-app-sg"
  description = "Terraform Security Group"
  vpc_id      = aws_default_vpc.default.id

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH"
  }

  # HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP"
  }


  # Outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "${var.env}-infra-app-sg"
  }
}

# EC2 Instance
resource "aws_instance" "my_instance" {
  count = var.instance_count

  #meta Argument
  depends_on = [aws_security_group.my_security_group, aws_key_pair.My_key]
                                                                              # Create multiple instances
  ami                    = var.ec2_ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.My_key.key_name
  vpc_security_group_ids = [aws_security_group.my_security_group.id]

  user_data = file("install_nginx.sh")

  root_block_device {
    volume_size = var.env == "prd" ? 20  : 10
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.env}-infra-app-instance"
    Environment = var.env
  }
}