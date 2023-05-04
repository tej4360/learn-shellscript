resource "aws_spot_instance_request" "sample_resource" {
  ami           = "ami-0089b8e98cd95257d"
  instance_type = "t3.micro"

  tags = {
    Name = "sample_resource"
  }
}