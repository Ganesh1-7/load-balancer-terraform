resource "aws_eip" "nat-eip1" {
    domain = "vpc"
    tags = {
        Name = "nat-eip1"
    }
}

resource "aws_eip" "nat-eip2" {
    domain = "vpc"
    tags = {
        Name = "nat-eip2"
    }
}


resource "aws_nat_gateway" "nat1" {
    allocation_id = aws_eip.nat-eip1.id
    subnet_id = aws_subnet.public-sub1.id
    depends_on = [ aws_internet_gateway.igw ]
    tags = {
        Name = "nat-gateway"
    }
}

resource "aws_nat_gateway" "nat2" {
    allocation_id = aws_eip.nat-eip2.id
    subnet_id = aws_subnet.public-sub2.id
    depends_on = [ aws_internet_gateway.igw ]
    tags = {
        Name = "nat-gateway2"
    }
}