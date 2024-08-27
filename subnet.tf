resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = var.cidr[count.index]
  availability_zone = var.az[count.index]
  count             = 2
  tags = {
    Name = "public"
  } 

}
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-south-1b"
  tags = {
    Name = "private"
  }

}
