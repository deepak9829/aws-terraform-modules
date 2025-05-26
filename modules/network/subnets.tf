resource "aws_subnet" "public" {
  count                   = 3
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true
  tags                    = merge(var.tags, { Name = "${var.name}-public-${var.azs[count.index]}" })
}

resource "aws_subnet" "private_app" {
  count             = 3
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_app_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]
  tags              = merge(var.tags, { Name = "${var.name}-private-app-${var.azs[count.index]}" })
}

resource "aws_subnet" "private_infra" {
  count             = 3
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_infra_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]
  tags              = merge(var.tags, { Name = "${var.name}-private-infra-${var.azs[count.index]}" })
}

resource "aws_subnet" "private_rds" {
  count             = 3
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_rds_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]
  tags              = merge(var.tags, { Name = "${var.name}-private-rds-${var.azs[count.index]}" })
}

resource "aws_subnet" "private_redis" {
  count             = 3
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_redis_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]
  tags              = merge(var.tags, { Name = "${var.name}-private-redis-${var.azs[count.index]}" })
}

resource "aws_subnet" "private_mongodb" {
  count             = 3
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_mongodb_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]
  tags              = merge(var.tags, { Name = "${var.name}-private-mongodb-${var.azs[count.index]}" })
}