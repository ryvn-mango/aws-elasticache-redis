output "cluster_id" {
  description = "The ID of the ElastiCache cluster"
  value       = aws_elasticache_cluster.this.id
}

output "cluster_address" {
  description = "The DNS name of the cache cluster without the port appended"
  value       = aws_elasticache_cluster.this.cache_nodes[0].address
}

output "endpoint" {
  description = "The endpoint URL for the Redis cluster"
  value       = "${aws_elasticache_cluster.this.cache_nodes[0].address}:${aws_elasticache_cluster.this.port}"
}

output "subnet_group_name" {
  description = "The name of the subnet group"
  value       = var.create_subnet_group ? aws_elasticache_subnet_group.this[0].name : var.subnet_group_name
}