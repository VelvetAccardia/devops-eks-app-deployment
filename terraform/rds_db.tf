resource "aws_db_instance" "rds_terraform" {
  db_name              = "rds_db"
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t33.micro"
  username             = rds_username
  password             = rds_password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}
