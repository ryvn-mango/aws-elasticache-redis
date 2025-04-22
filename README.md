# AWS ElastiCache Redis Terraform Module

A simplified Terraform module for creating an AWS ElastiCache Redis cluster.

## Usage

```hcl
module "redis" {
  source = "github.com/your-org/terraform-aws-elasticache-redis"

  region     = "us-west-2"
  vpc_id     = "vpc-1234567890"
  node_type  = "cache.r7g.large"  # Default node type
  subnet_ids = ["subnet-12345678", "subnet-87654321"]  # Required
  
  # Define who can access Redis
  allowed_cidr_blocks = ["10.0.0.0/16"]  # VPC CIDR
  
  tags = {
    Environment = "dev"
    Project     = "example"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| aws | >= 4.0.0 |
| random | >= 3.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| region | AWS region | string | n/a | yes |
| vpc_id | VPC ID where the Redis cluster will be created | string | n/a | yes |
| allowed_cidr_blocks | List of CIDR blocks that can access the Redis cluster | list(string) | n/a | yes |
| subnet_ids | List of VPC Subnet IDs for the cache subnet group | list(string) | n/a | yes |
| node_type | The compute and memory capacity of the nodes | string | "cache.r7g.large" | no |
| tags | A map of tags to add to all resources | map(string) | {} | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster_id | The ID of the ElastiCache cluster |
| cluster_address | The DNS name of the cache cluster |
| endpoint | The endpoint URL for the Redis cluster |

## Notes

- The cluster ID is automatically generated with a 'redis-' prefix
- Redis version 7.1 is used
- Uses default Redis 7.1 parameter group
- Single node configuration (fixed)
- Uses cache.r7g.large instance type by default
- Default Redis port (6379) is used
- Security group is created with inbound access on port 6379 from specified CIDR blocks
- Subnet group is always created with the provided subnet IDs (required)

## License

MIT Licensed. See LICENSE for full details.