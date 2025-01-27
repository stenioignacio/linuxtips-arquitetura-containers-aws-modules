resource "aws_security_group" "lb" {
  name   = format("%s-ingress", var.project_name)
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "ingress-80" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 80
  to_port           = 80
  description       = "liberando porta 80"
  protocol          = "tcp"
  security_group_id = aws_security_group.lb.id
  type              = "ingress"
}

resource "aws_security_group_rule" "ingress-443" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 443
  to_port           = 443
  description       = "liberando porta 443"
  protocol          = "tcp"
  security_group_id = aws_security_group.lb.id
  type              = "ingress"
}

resource "aws_lb" "main" {
  name               = format("%s-ingress", var.project_name)
  internal           = "false"
  load_balancer_type = "application"

  subnets = var.public_subnets

  security_groups = [aws_security_group.lb.id]

  enable_deletion_protection       = false
  enable_cross_zone_load_balancing = false
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "linuxtips"
      status_code  = "200"
    }
  }
}
