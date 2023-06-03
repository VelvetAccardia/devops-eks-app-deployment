resource "aws_db_instance" "rds_terraform" {
  db_name                = var.db_name
  allocated_storage      = var.allocated_storage
  engine                 = var.db_engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = var.parameter_group_name
  vpc_security_group_ids = [aws_security_group.instance.id]
  skip_final_snapshot    = var.skip_final_snapshot
}
