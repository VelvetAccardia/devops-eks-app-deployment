variable "kubeconfig" {
  type    = string
  default = "~/.kube/eks-kubeconfig.yaml"
}

variable "aws_region" {
  type = string
}

variable "cluster" {
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

variable "cidr_block_sub_pub_1_us_west_1" {
  type    = string
  default = "192.168.0.0/26"
}

variable "cidr_block_sub_pub_2_us_west_1" {
  type    = string
  default = "192.168.0.64/26"
}

variable "cidr_block_sub_pvt_1_us_west_1" {
  type    = string
  default = "192.168.0.128/26"
}

variable "cidr_block_sub_pvt_2_us_west_1" {
  type    = string
  default = "192.168.0.192/26"
}

variable "aws_availability_zone_1" {
  type = string
}

variable "aws_availability_zone_2" {
  type = string
}

variable "endpoint_private_access" {
  type    = bool
  default = true
}

variable "endpoint_public_access" {
  type    = bool
  default = true
}

variable "pub_subnet_id_1" {
  type    = string
  default = "subnet-0bda61fa563bf0651"
}

variable "pub_subnet_id_2" {
  type    = string
  default = "subnet-0fb3e26a1141a56c4"
}
variable "pvt_subnet_id_1" {
  type    = string
  default = "subnet-0a02b094f6482bdef"
}

variable "pvt_subnet_id_2" {
  type    = string
  default = "subnet-01319ddc41733de32"
}

variable "domain" {
  type = string
}

variable "cname" {
  type = string
}
