resource "random_id" "cluster_id" {
  byte_length = 4
  prefix      = "redis-"
}

resource "aws_security_group" "redis" {
  name        = "${random_id.cluster_id.hex}-redis-sg"
  description = "Security group for Redis cluster ${random_id.cluster_id.hex}"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      "Name" = "${random_id.cluster_id.hex}-redis-sg"
    },
    var.tags
  )
}

resource "aws_elasticache_subnet_group" "this" {
  name       = "${random_id.cluster_id.hex}-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_elasticache_cluster" "this" {
  cluster_id           = random_id.cluster_id.hex
  engine              = "redis"
  node_type           = var.node_type
  num_cache_nodes     = 1
  parameter_group_name = "default.redis7.1"
  port                = 6379
  subnet_group_name   = aws_elasticache_subnet_group.this.name
  security_group_ids  = [aws_security_group.redis.id]
  engine_version      = "7.1"

  tags = merge(
    {
      "Name" = random_id.cluster_id.hex
    },
    var.tags
  )
}
