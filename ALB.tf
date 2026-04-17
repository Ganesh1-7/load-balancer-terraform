resource "aws_lb" "alb" {
    name = "web-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.lb-sg.id]
    subnets = [aws_subnet.public-sub1.id, aws_subnet.public-sub2.id]
    tags = {
        Name = "web-alb"
    }
}

resource "aws_lb_target_group" "tg" {
    name = "web-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.main.id
    health_check {
        path = "/"
        protocol = "HTTP"
        interval = 30
        timeout = 5
        healthy_threshold = 2
        unhealthy_threshold = 2
    }
    tags = {
        Name = "web-tg"
    }
}

resource "aws_lb_listener" "listener" {
    load_balancer_arn = aws_lb.alb.arn
    port = 80
    protocol = "HTTP"
    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.tg.arn
    }
}

resource "aws_lb_target_group_attachment" "tg_attachment" {
    count = 4
    target_group_arn = aws_lb_target_group.tg.arn
    target_id = aws_instance.web[count.index].id
    port = 80
}