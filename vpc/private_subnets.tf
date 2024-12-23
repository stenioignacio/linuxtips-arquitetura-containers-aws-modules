resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id = aws_vpc.main.id

  cidr_block        = var.private_subnets[count.index].cidr
  availability_zone = var.private_subnets[count.index].availability_zones

  tags = {
    Name = "private-subnet-${var.project_name}"
  }
}

resource "aws_eip" "eip" {
  count = length(var.public_subnets)

  domain = "vpc"

  tags = {
    Name = "eip-${var.project_name}-${var.public_subnets[count.index].availability_zones}"
  }
}

resource "aws_nat_gateway" "private" {
  count = length(var.public_subnets)

  allocation_id = aws_eip.eip[count.index]

  subnet_id = aws_subnet.public[count.index].id

  tags = {
    Name = "nat-gtw-${var.project_name}-${var.public_subnets[count.index].availability_zones}"
  }
}

resource "aws_route_table" "private" {
  count = length(var.private_subnets)

  vpc_id = aws_vpc.main.id
  tags = {
    Name = "private-${var.project_name}-${var.private_subnets[count.index].availability_zones}"
  }
}

resource "aws_route" "private" {
  count                  = length(var.private_subnets)
  destination_cidr_block = "0.0.0.0/0"

  route_table_id = aws_route_table.private[count.index].id
  gateway_id     = aws_nat_gateway.private[count.index].id
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnets)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route.private[count.index].id
}
