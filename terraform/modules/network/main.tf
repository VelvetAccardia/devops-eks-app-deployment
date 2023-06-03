resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.tag_name
  }
}



resource "aws_subnet" "sub_pub_us_west_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.cidr_block_sub_pub_us_west_1
  availability_zone = var.aws_availability_zone


  tags = {
    Name = "sub_pub_us_west_1"
  }

}

resource "aws_subnet" "sub_pvt_us_west_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.cidr_block_sub_pvt_us_west_1
  availability_zone = var.aws_availability_zone

  tags = {
    Name = "sub_pvt_us_west_1"
  }

}

resource "aws_route_table" "rt_pub" {
  vpc_id = aws_vpc.main.id

}

resource "aws_route_table" "rt_pvt" {
  vpc_id = aws_vpc.main.id
}
