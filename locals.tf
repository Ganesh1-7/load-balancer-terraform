
locals {
  subnets = [
    aws_subnet.private-sub3.id,
    aws_subnet.private-sub4.id,
    aws_subnet.private-sub3.id,
    aws_subnet.private-sub4.id
  ]
}
