resource "aws_security_group" "main" {
  name   = format(var.project_name)
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "subnet-range" {
  protocol          = "-1"
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  description       = "Liberando trafego pra vpc"
  security_group_id = aws_security_group.main.id
  cidr_blocks       = ["10.0.0.0/16"]
}
