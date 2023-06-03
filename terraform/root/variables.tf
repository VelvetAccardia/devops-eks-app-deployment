variable "aws_region" {
  type = string
}

variable "cidr_block" {
  type    = string
  default = "192.168.0.0/24"
}

variable "tag_name" {
  type    = string
  default = "main_vpc"
}


variable "db_name" {
  type    = string
  default = "aws_terraform_db"
}
variable "allocated_storage" {
  type    = number
  default = 10
}

variable "db_engine" {
  type    = string
  default = "mysql"
}

variable "engine_version" {
  type    = string
  default = "5.7"
}

variable "instance_class" {
  type    = string
  default = "db.t2.micro"
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

variable "parameter_group_name" {
  type    = string
  default = "default.mysql5.7"
}

variable "skip_final_snapshot" {
  type    = bool
  default = true
}

variable "cidr_block_sub_pub_us_west_1" {
  type    = string
  default = "192.168.0.0/25"
}

variable "cidr_block_sub_pvt_us_west_1" {
  type    = string
  default = "192.168.0.128/25"
}


variable "aws_availability_zone" {
  type = string
}
