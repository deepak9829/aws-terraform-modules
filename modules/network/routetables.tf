resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge(var.tags, { Name = "${var.name}-public-rt" })
}

resource "aws_route_table_association" "public" {
  count          = 3
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = merge(var.tags, { Name = "${var.name}-private-rt-shared" })
}

resource "aws_route_table_association" "private_all" {
  count = 15
  subnet_id = element(
    concat(
      aws_subnet.private_app[*].id,
      aws_subnet.private_infra[*].id,
      aws_subnet.private_rds[*].id,
      aws_subnet.private_redis[*].id,
      aws_subnet.private_mongodb[*].id
    ),
    count.index
  )
  route_table_id = aws_route_table.private.id
}