resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id = aws_vpc.main.id

  cidr_block        = var.public_subnets[count.index].cidr
  availability_zone = var.public_subnets[count.index].availability_zones

  tags = {
    Name = "public-subnet-${var.project_name}"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.project_name
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "rt-public-access-${var.project_name}"
  }
}

resource "aws_route" "public_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"

  gateway_id = aws_internet_gateway.gw.id
}


resource "aws_route_table_association" "public" {
  count = length(var.public_subnets)

  subnet_id = aws_subnet.public[count.index].id

  route_table_id = aws_route_table.public.id
}
