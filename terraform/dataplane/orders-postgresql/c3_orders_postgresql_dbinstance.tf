resource "aws_db_instance" "orders_postgresql" {

  identifier = "${var.environment_name}-orders-postgresql"

  engine = "postgres"

  engine_version = "17.6"

  instance_class = "db.t4g.micro"

  allocated_storage = 20

  max_allocated_storage = 100

  storage_type = "gp3"

  storage_encrypted = true

  db_name = "orders"

  username = "postgres"

  manage_master_user_password = true

  db_subnet_group_name = aws_db_subnet_group.orders_postgresql.name

  vpc_security_group_ids = [
    aws_security_group.orders_postgresql.id
  ]

  publicly_accessible = false

  multi_az = false

  backup_retention_period = 7

  deletion_protection = false

  auto_minor_version_upgrade = true

  apply_immediately = true

  skip_final_snapshot = true

  tags = merge(
    var.tags,
    {
      Name        = "${var.environment_name}-orders-postgresql"
      Application = "orders"
      Database    = "postgresql"
    }
  )

}