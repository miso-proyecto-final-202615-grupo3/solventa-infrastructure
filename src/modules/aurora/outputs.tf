output "cluster_id" {
  description = "The ID of the RDS instance"
  value       = aws_db_instance.this.id
}

output "cluster_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = aws_db_instance.this.address
}

output "cluster_port" {
  description = "The database port"
  value       = aws_db_instance.this.port
}

output "instance_id" {
  description = "The ID of the database instance"
  value       = aws_db_instance.this.id
}
