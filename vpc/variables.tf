variable "project_region" {
  type        = string
  description = "Região do projeto"
}
variable "project_name" {
  type        = string
  description = "Nome do projeto"
}
variable "cidr_block" {
  type = string
}
variable "availability_zones" {
  type = list(string)
}
variable "private_subnets" {
  type = list(map({
    name               = string
    cidr               = string
    availability_zones = string
  }))
}
variable "public_subnets" {
  type = list(map({
    name               = string
    cidr               = string
    availability_zones = string
  }))
}
