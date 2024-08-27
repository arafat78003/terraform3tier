resource "aws_eip" "myeip" {
  //instance = aws_instance.public.id
  domain = "vpc"

}