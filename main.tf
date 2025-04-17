resource "random_id" "cluster_id" {
  byte_length = 4
  prefix      = "redis-"
}

resource "aws_elasticache_subnet_group" "this" {
  count      = var.create_subnet_group ? 1 : 0
  name       = "${random_id.cluster_id.hex}-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_elasticache_cluster" "this" {
  cluster_id           = random_id.cluster_id.hex
  engine               = "redis"
  node_type            = var.node_type
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7.0"
  port                 = 6379
  subnet_group_name    = var.create_subnet_group ? aws_elasticache_subnet_group.this[0].name : var.subnet_group_name
  security_group_ids   = var.security_group_ids
  engine_version       = "7.0"

  tags = merge(
    {
      "Name" = random_id.cluster_id.hex
    },
    var.tags
  )
}
