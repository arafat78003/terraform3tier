resource "aws_nat_gateway" "mynat" {
  allocation_id = aws_eip.myeip.id
  subnet_id     = aws_subnet.public[0].id
  tags = {
    Name = "mynat"
  }
  depends_on = [aws_internet_gateway.gw]

}