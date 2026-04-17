resource "aws_route_table" "rt2" {
    vpc_id = aws_vpc.main.id
    route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = "public-rt"
    }
}


resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat1.id
  }
  tags = {
    Name = "private-rt-az1"
  }
}

resource "aws_route_table" "rt-2" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat2.id
  }
  tags = {
    Name = "private-rt-az2"
  }
}


resource "aws_route_table_association" "rta3" {
    subnet_id = aws_subnet.public-sub1.id
    route_table_id = aws_route_table.rt2.id
}

resource "aws_route_table_association" "rta4" {
    subnet_id = aws_subnet.public-sub2.id
    route_table_id = aws_route_table.rt2.id
}


resource "aws_route_table_association" "rta1" {
    subnet_id = aws_subnet.private-sub3.id
    route_table_id = aws_route_table.rt1.id
}

resource "aws_route_table_association" "rta2" {
    subnet_id = aws_subnet.private-sub4.id
    route_table_id = aws_route_table.rt-2.id
}