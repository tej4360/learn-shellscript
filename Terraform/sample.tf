resource "aws_spot_instance_request" "cheap_worker" {
  ami           = "ami-0089b8e98cd95257d"
  spot_price    = "0.03"
  instance_type = "c4.xlarge"

  tags = {
    Name = "CheapWorker"
  }
}