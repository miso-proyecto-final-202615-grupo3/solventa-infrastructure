resource "aws_security_group" "this" {
  name        = "${var.replication_group_id}-sg"
  description = "Allow Redis traffic from private compute subnets"
  vpc_id      = var.vpc_id

  ingress {
    description = "Redis from private compute subnets"
    from_port   = var.port
    to_port     = var.port
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = "${var.replication_group_id}-sg" })
}

resource "aws_elasticache_subnet_group" "this" {
  name       = "${var.replication_group_id}-subnets"
  subnet_ids = var.subnet_ids

  tags = merge(var.tags, { Name = "${var.replication_group_id}-subnets" })
}

resource "aws_elasticache_replication_group" "this" {
  replication_group_id       = var.replication_group_id
  description                = var.description
  engine                     = "valkey"
  engine_version             = var.engine_version
  node_type                  = var.node_type
  port                       = var.port
  num_cache_clusters         = var.num_cache_clusters
  automatic_failover_enabled = var.num_cache_clusters > 1
  multi_az_enabled           = var.num_cache_clusters > 1
  subnet_group_name          = aws_elasticache_subnet_group.this.name
  security_group_ids         = [aws_security_group.this.id]
  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  transit_encryption_enabled = var.transit_encryption_enabled
  auth_token                 = var.auth_token
  snapshot_retention_limit   = var.snapshot_retention_limit
  apply_immediately          = var.apply_immediately

  tags = merge(var.tags, { Name = var.replication_group_id })
}
