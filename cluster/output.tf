output "cluster_name" {
  value = aws_ecs_cluster.main.name
}

output "load-balancer-dns" {
  value = aws_lb.main.dns_name
}
output "lb_external_arn" {
  value = aws_lb.main.arn
}

output "lb_external_listener" {
  value = aws_lb_listener.main.arn
}

output "lb_internal_arn" {
  value = aws_lb.internal.arn
}

output "lb_internal_listener" {
  value = aws_lb_listener.internal.arn
}

output "internal-load-balancer-dns" {
  value = aws_lb.internal.dns_name
}

output "service_discovery_cloudmap" {
  value = aws_service_discovery_private_dns_namespace.main.id
}

output "service_discovery_cloudmap_name" {
  value = aws_service_discovery_private_dns_namespace.main.name
}

output "service_discovery_service_connect" {
  value = aws_service_discovery_private_dns_namespace.sc.id
}

output "service_discovery_service_connect_name" {
  value = aws_service_discovery_private_dns_namespace.sc.name
}

output "vpc_link_nlb_arn" {
  value = aws_lb.vpclink.arn
}

output "vpc_link_id" {
  value = aws_lb.vpclink.id
}
