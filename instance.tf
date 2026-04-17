resource "aws_instance" "web" {
    count = 4
    ami = "ami-05d2d839d4f73aafb"
    instance_type = "t3.micro"
    key_name = aws_key_pair.web-key.key_name
    vpc_security_group_ids = [aws_security_group.sg1.id]
    subnet_id = local.subnets[count.index]
    user_data = file("user-data.sh")
    tags = {
        Name = var.instances[count.index]
    }
}

resource "aws_instance" "bastion" {
    ami = "ami-05d2d839d4f73aafb"
    instance_type = "t3.micro"
    key_name = aws_key_pair.web-key.key_name
    vpc_security_group_ids = [aws_security_group.sg1.id]
    subnet_id = aws_subnet.public-sub1.id
    associate_public_ip_address = true
    tags = {
        Name = "bastion-host"
    }
}