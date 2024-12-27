variable "project_name" {
}
variable "region" {
}
variable "vpc_id" {
  type = string
}
variable "private_subnets" {
  type = list(string)
}
variable "public_subnets" {
  type = list(string)
}

### ECS ###
variable "capacity_providers" {
  type    = list(any)
  default = ["FARGATE", "FARGATE_SPOT"]
}
