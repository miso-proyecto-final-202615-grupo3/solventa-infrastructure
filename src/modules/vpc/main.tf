resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(var.tags, {
    Name = var.vpc_name
  })
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, {
    Name = var.internet_gateway_name
  })
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name                     = "${var.subnet_name_prefix}-public-${count.index + 1}"
    Type                     = "public"
    "kubernetes.io/role/elb" = "1"
  })
}

resource "aws_subnet" "private_compute" {
  count = length(var.private_compute_subnet_cidrs)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_compute_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = merge(var.tags, {
    Name = "${var.subnet_name_prefix}-private-compute-${count.index + 1}"
    Type = "private-compute"
  })
}

resource "aws_subnet" "private_database" {
  count = length(var.private_database_subnet_cidrs)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_database_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = merge(var.tags, {
    Name = "${var.subnet_name_prefix}-private-database-${count.index + 1}"
    Type = "private-database"
  })
}

resource "aws_eip" "nat" {
  domain = "vpc"

  depends_on = [aws_internet_gateway.this]

  tags = merge(var.tags, {
    Name = var.nat_gateway_name
  })
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = merge(var.tags, {
    Name = var.nat_gateway_name
  })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(var.tags, {
    Name = var.public_route_table_name
  })
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }

  tags = merge(var.tags, {
    Name = var.private_route_table_name
  })
}

resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_compute" {
  count = length(aws_subnet.private_compute)

  subnet_id      = aws_subnet.private_compute[count.index].id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_database" {
  count = length(aws_subnet.private_database)

  subnet_id      = aws_subnet.private_database[count.index].id
  route_table_id = aws_route_table.private.id
}
