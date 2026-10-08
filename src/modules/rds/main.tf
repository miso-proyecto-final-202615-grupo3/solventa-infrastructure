resource "aws_security_group" "this" {
  name        = "${var.cluster_identifier}-sg"
  description = "Allow RDS PostgreSQL traffic from the application VPC"
  vpc_id      = var.vpc_id

  ingress {
    description = "PostgreSQL from the VPC"
    from_port   = var.port
    to_port     = var.port
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  ingress {
    description = "PostgreSQL from the internet"
    from_port   = var.port
    to_port     = var.port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = "${var.cluster_identifier}-sg" })
}

resource "aws_db_instance" "this" {
  identifier              = var.cluster_identifier
  engine                  = "postgres"
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  max_allocated_storage   = var.max_allocated_storage
  storage_type            = "gp2"
  db_name                 = var.database_name
  username                = var.master_username
  password                = var.master_password
  port                    = var.port
  backup_retention_period = var.backup_retention_period
  backup_window           = var.preferred_backup_window
  maintenance_window      = var.preferred_maintenance_window
  storage_encrypted       = var.storage_encrypted
  parameter_group_name    = aws_db_parameter_group.this.name
  vpc_security_group_ids  = [aws_security_group.this.id]
  db_subnet_group_name    = aws_db_subnet_group.this.name
  skip_final_snapshot     = var.skip_final_snapshot
  deletion_protection     = var.deletion_protection
  apply_immediately       = var.apply_immediately
  publicly_accessible     = true

  tags = merge(var.tags, { Name = var.cluster_identifier })
}

resource "aws_db_subnet_group" "this" {
  name       = var.subnet_group_name
  subnet_ids = var.subnet_ids

  tags = merge(var.tags, { Name = var.subnet_group_name })
}

resource "aws_db_parameter_group" "this" {
  name        = var.parameter_group_name
  family      = var.parameter_group_family
  description = "Parameters for ${var.cluster_identifier}"

  parameter {
    name  = "log_statement"
    value = "all"
  }

  tags = merge(var.tags, { Name = var.parameter_group_name })
}
