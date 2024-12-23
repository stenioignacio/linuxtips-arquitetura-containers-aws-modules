output "vpc_main" {
  value       = aws_vpc.main.id
  description = "ID da vpc"
}

output "public_subnets" {
  value = aws_subnet.public[*].id
}

output "private_subnets" {
  value = aws_subnet.private[*].id
}
