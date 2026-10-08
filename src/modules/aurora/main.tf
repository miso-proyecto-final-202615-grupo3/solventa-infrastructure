resource "aws_security_group" "this" {
  name        = "${var.cluster_identifier}-sg"
  description = "Allow Aurora PostgreSQL traffic from the application VPC"
  vpc_id      = var.vpc_id

  ingress {
    description = "PostgreSQL from the VPC"
    from_port   = var.port
    to_port     = var.port
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = "${var.cluster_identifier}-sg" })
}

resource "aws_rds_cluster" "this" {
  cluster_identifier              = var.cluster_identifier
  engine                          = "aurora-postgresql"
  engine_mode                     = "provisioned"
  storage_type                    = "aurora-iopt1"
  engine_version                  = var.engine_version
  database_name                   = var.database_name
  master_username                 = var.master_username
  master_password                 = var.master_password
  port                            = var.port
  preferred_backup_window         = var.preferred_backup_window
  backup_retention_period         = var.backup_retention_period
  preferred_maintenance_window    = var.preferred_maintenance_window
  storage_encrypted               = var.storage_encrypted
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.this.name
  vpc_security_group_ids          = [aws_security_group.this.id]
  db_subnet_group_name            = aws_db_subnet_group.this.name
  skip_final_snapshot             = var.skip_final_snapshot
  deletion_protection             = var.deletion_protection
  apply_immediately               = var.apply_immediately
  serverlessv2_scaling_configuration {
    max_capacity             = var.serverlessv2_scaling_configuration.max_capacity
    min_capacity             = var.serverlessv2_scaling_configuration.min_capacity
    seconds_until_auto_pause = var.serverlessv2_scaling_configuration.seconds_until_auto_pause
  }
  tags = merge(var.tags, { Name = var.cluster_identifier })
}

resource "aws_rds_cluster_instance" "this" {
  count = var.instance_count

  identifier         = "${var.cluster_identifier}-${count.index + 1}"
  cluster_identifier = aws_rds_cluster.this.id
  instance_class     = var.instance_class
  engine             = aws_rds_cluster.this.engine
  apply_immediately  = var.apply_immediately
  tags               = merge(var.tags, { Name = "${var.cluster_identifier}-${count.index + 1}" })
}

resource "aws_db_subnet_group" "this" {
  name       = var.subnet_group_name
  subnet_ids = var.subnet_ids

  tags = merge(var.tags, { Name = var.subnet_group_name })
}

resource "aws_rds_cluster_parameter_group" "this" {
  name        = var.parameter_group_name
  family      = var.parameter_group_family
  description = "Parameters for ${var.cluster_identifier}"

  parameter {
    name  = "log_statement"
    value = "all"
  }

  tags = merge(var.tags, { Name = var.parameter_group_name })
}
