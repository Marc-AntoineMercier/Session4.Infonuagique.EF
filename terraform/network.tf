
resource "aws_vpc" "epreuve_final" {
  cidr_block = var.ep_vpc.vpc_plage_adr
  tags = {
    Name = var.ep_vpc.vpc_name
  }
}


resource "aws_subnet" "public_subnets" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.epreuve_final.id
  cidr_block        = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "epreuve-finale-public-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.epreuve_final.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "epreuve-finale-private-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.epreuve_final.id

  tags = {
    Name = var.internet_gateway
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.epreuve_final.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  route {
    cidr_block = var.ep_vpc.vpc_plage_adr
    gateway_id = "local"
  }

  tags = {
    Name = var.public_route_table
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.epreuve_final.id

  route {
    cidr_block = var.ep_vpc.vpc_plage_adr
    gateway_id = "local"
  }

  tags = {
    Name = var.private_route_table
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_subnet_association" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
  route_table_id = aws_route_table.private_rt.id
}

