resource "aws_security_group" "vpclink" {
  name   = format("%s-vpc-link", var.project_name)
  vpc_id = var.vpc_id

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}

resource "aws_security_group_rule" "vpclink" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 80
  to_port           = 80
  description       = "liberando porta 80"
  protocol          = "tcp"
  security_group_id = aws_security_group.vpclink.id
  type              = "ingress"
}

resource "aws_lb" "vpclink" {
  name     = format("%s-vpc-link", var.project_name)
  internal = true

  load_balancer_type = "network"

  subnets = var.private_subnets

  security_groups = [aws_security_group.vpclink.id]

  enable_deletion_protection       = false
  enable_cross_zone_load_balancing = false
}

resource "aws_lb_target_group" "vpclink" {
  name        = "vpc-link"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"

  vpc_id = var.vpc_id

  target_health_state {
    enable_unhealthy_connection_termination = false
  }
}

resource "aws_lb_listener" "vpclink" {
  load_balancer_arn = aws_lb.vpclink.arn

  port     = 80
  protocol = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.vpclink.arn
  }
}

resource "aws_lb_target_group_attachment" "internal_lb" {
  target_group_arn = aws_lb_target_group.vpclink.arn
  target_id        = aws_lb.internal.arn
  port             = 80

  depends_on = [aws_lb_listener.internal, aws_lb_target_group.vpclink, aws_lb.internal]
}

resource "aws_api_gateway_vpc_link" "main" {
  name = var.project_name

  target_arns = [
    aws_lb.vpclink.arn
  ]
}
