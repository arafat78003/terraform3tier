resource "aws_instance" "web" {
  ami                         = "ami-02b49a24cfb95941c"
  instance_type               = "t2.micro"
  key_name                    = "vishal"
  subnet_id                   = aws_subnet.public[count.index].id
  vpc_security_group_ids      = [aws_security_group.allow_tls1.id]
  associate_public_ip_address = true
  count                       = 2
  tags = {
    Name = "webserver"
  }

  provisioner "file" {
    source      = "./vishal.pem"
    destination = "/home/ec2-user/vishal.pem"

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      private_key = "${file("./vishal.pem")}"

    }
  }
}
resource "aws_instance" "dbserver" {
  ami                    = "ami-02b49a24cfb95941c"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private.id
  key_name               = "vishal"
  vpc_security_group_ids = [aws_security_group.allow_tls_db.id]
  tags = {
    Name = "dbserver"
  }

}
    