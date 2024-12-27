resource "aws_service_discovery_private_dns_namespace" "main" {
  name        = format("%s.discovery.com", var.project_name)
  description = "Service Discovery para o cluster de ECS"
  vpc         = var.vpc_id
}

resource "aws_service_discovery_private_dns_namespace" "sc" {
  name        = format("%s.local", var.project_name)
  description = "Service Connect para o cluster de ECS"
  vpc         = var.vpc_id
}
