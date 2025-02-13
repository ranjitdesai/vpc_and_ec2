
# Create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

# Create Subnet
resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
}

# Create Security Group
resource "aws_security_group" "my_sg" {
  vpc_id = aws_vpc.my_vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Launch EC2 Instance (depends on VPC)
resource "aws_instance" "my_instance" {
  ami           = "ami-05fa46471b02db0ce"  # Replace with a valid AMI ID
  instance_type = "t2.micro"
  count = 2
  subnet_id     = aws_subnet.my_subnet.id
  security_groups = [aws_security_group.my_sg.id]

  depends_on = [aws_vpc.my_vpc]  # Ensures VPC is created first
  tags = {
    Name= "ranjit"
  }
}
