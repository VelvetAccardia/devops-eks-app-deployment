resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.tag_name
  }
}

resource "aws_subnet" "sub_pub_1_us_west_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.cidr_block_sub_pub_1_us_west_1
  availability_zone = var.aws_availability_zone_1

  tags = {
    Name                                       = "sub_pub_1_us_west_1"
    "kubernetes.io/cluster/eks_devops_cluster" = "shared"
  }
}

resource "aws_subnet" "sub_pub_2_us_west_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.cidr_block_sub_pub_2_us_west_1
  availability_zone = var.aws_availability_zone_2

  tags = {
    Name                                       = "sub_pub_2_us_west_1"
    "kubernetes.io/cluster/eks_devops_cluster" = "shared"
  }
}

resource "aws_subnet" "sub_pvt_1_us_west_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.cidr_block_sub_pvt_1_us_west_1
  availability_zone = var.aws_availability_zone_1

  tags = {
    Name                                       = "sub_pvt_1_us_west_1"
    "kubernetes.io/cluster/eks_devops_cluster" = "shared"
  }
}

resource "aws_subnet" "sub_pvt_2_us_west_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.cidr_block_sub_pvt_2_us_west_1
  availability_zone = var.aws_availability_zone_2

  tags = {
    Name                                       = "sub_pvt_2_us_west_1"
    "kubernetes.io/cluster/eks_devops_cluster" = "shared"
  }
}

resource "aws_route_table" "rt_pub" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig_pub.id
  }

  tags = {
    Name = "rt_pub"
  }
}

resource "aws_route_table" "rt_pvt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "rt_pvt"
  }
}

resource "aws_route_table_association" "pub_association_1" {
  subnet_id      = aws_subnet.sub_pub_1_us_west_1.id
  route_table_id = aws_route_table.rt_pub.id
}

resource "aws_route_table_association" "pub_association_2" {
  subnet_id      = aws_subnet.sub_pub_2_us_west_1.id
  route_table_id = aws_route_table.rt_pub.id
}

resource "aws_route_table_association" "pvt_association_1" {
  subnet_id      = aws_subnet.sub_pvt_1_us_west_1.id
  route_table_id = aws_route_table.rt_pvt.id
}

resource "aws_route_table_association" "pvt_association_2" {
  subnet_id      = aws_subnet.sub_pvt_2_us_west_1.id
  route_table_id = aws_route_table.rt_pvt.id
}

resource "aws_internet_gateway" "ig_pub" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "ig_pub"
  }
}

resource "aws_eip" "nat" {
  vpc = true

  tags = {
    Name = "nat"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.sub_pub_1_us_west_1.id

  tags = {
    Name = "nat"
  }

  depends_on = [aws_internet_gateway.ig_pub]
}
resource "aws_security_group" "TF_SG" {
  name   = "Security Group Terraform"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "Traffic from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Security Group Terraform"
  }
}
resource "aws_lb" "load_balancer" {
  name               = "loadbalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.TF_SG.id]
  subnets            = [aws_subnet.sub_pub_1_us_west_1.id, aws_subnet.sub_pub_2_us_west_1.id]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "target_group" {
  name     = "lb-target-group"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id


}


resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

resource "aws_route53_zone" "zone" {
  name = var.domain
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.zone.id
  name    = var.domain
  type    = "A"

  alias {
    name                   = aws_lb.load_balancer.dns_name
    zone_id                = aws_lb.load_balancer.zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "cname" {
  zone_id = aws_route53_zone.zone.id
  name    = var.cname
  type    = "CNAME"
  records = [aws_lb.load_balancer.dns_name]
  ttl     = "300"
}
