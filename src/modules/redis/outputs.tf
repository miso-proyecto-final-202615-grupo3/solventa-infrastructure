output "replication_group_id" {
  description = "The ID of the Redis replication group."
  value       = aws_elasticache_replication_group.this.id
}

output "primary_endpoint_address" {
  description = "The primary endpoint for Redis connections."
  value       = aws_elasticache_replication_group.this.primary_endpoint_address
}

output "reader_endpoint_address" {
  description = "The reader endpoint for Redis connections."
  value       = aws_elasticache_replication_group.this.reader_endpoint_address
}

output "port" {
  description = "The port used by Redis."
  value       = aws_elasticache_replication_group.this.port
}