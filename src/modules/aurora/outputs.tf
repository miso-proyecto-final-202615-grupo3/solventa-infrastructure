output "cluster_id" {
  value = aws_rds_cluster.this.id
}

output "cluster_endpoint" {
  value = aws_rds_cluster.this.endpoint
}

output "cluster_reader_endpoint" {
  value = aws_rds_cluster.this.reader_endpoint
}

output "cluster_port" {
  value = aws_rds_cluster.this.port
}

output "instance_ids" {
  value = aws_rds_cluster_instance.this[*].id
}
