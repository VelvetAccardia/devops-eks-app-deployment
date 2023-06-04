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
    Name                        = "sub_pub_1_us_west_1"
    "kubernetes.io/cluster/eks" = "shared"
  }
}

resource "aws_subnet" "sub_pub_2_us_west_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.cidr_block_sub_pub_2_us_west_1
  availability_zone = var.aws_availability_zone_2

  tags = {
    Name                        = "sub_pub_2_us_west_1"
    "kubernetes.io/cluster/eks" = "shared"
  }
}

resource "aws_subnet" "sub_pvt_1_us_west_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.cidr_block_sub_pvt_1_us_west_1
  availability_zone = var.aws_availability_zone_1

  tags = {
    Name                        = "sub_pvt_1_us_west_1"
    "kubernetes.io/cluster/eks" = "shared"
  }
}

resource "aws_subnet" "sub_pvt_2_us_west_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.cidr_block_sub_pvt_2_us_west_1
  availability_zone = var.aws_availability_zone_2

  tags = {
    Name                        = "sub_pvt_2_us_west_1"
    "kubernetes.io/cluster/eks" = "shared"
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
