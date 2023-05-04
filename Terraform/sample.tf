resource "aws_instance" "web" {
  ami           = "ami-0089b8e98cd95257d"
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
  }
}