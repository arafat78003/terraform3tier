resource "aws_lb" "mylb" {
  name               = "mylb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_tls1.id]
  subnets            = [for subnet in aws_subnet.public : subnet.id]

  enable_deletion_protection = false
  tags = {
    Name = "mylb"
  }

}

resource "aws_lb_target_group" "mytg" {
  name        = "mytg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.myvpc.id

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 5
    interval            = 10
    path                = "/"
    port                = 80
  }

}

resource "aws_lb_target_group_attachment" "front_end" {
  target_group_arn = aws_lb_target_group.mytg.arn
  target_id        = aws_instance.web[count.index].id
  port             = 80
  count            = 2


}

resource "aws_lb_listener" "mylistner" {
  load_balancer_arn = aws_lb.mylb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.mytg.arn
  }


}
