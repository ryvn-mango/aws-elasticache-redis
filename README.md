# AWS ElastiCache Redis Terraform Module

A simplified Terraform module for creating an AWS ElastiCache Redis cluster.

## Usage

```hcl
module "redis" {
  source = "github.com/your-org/terraform-aws-elasticache-redis"

  region     = "us-west-2"
  node_type  = "cache.t3.micro"
  subnet_ids = ["subnet-12345678", "subnet-87654321"]
  
  # Optional: Security groups
  security_group_ids = ["sg-12345678"]
  
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
| node_type | The compute and memory capacity of the nodes | string | "cache.t3.micro" | no |
| subnet_group_name | Name for the cache subnet group (if not creating one) | string | null | no |
| create_subnet_group | Whether to create a subnet group | bool | true | no |
| subnet_ids | List of VPC Subnet IDs for the cache subnet group | list(string) | [] | no |
| security_group_ids | List of VPC security group IDs | list(string) | [] | no |
| tags | A map of tags to add to all resources | map(string) | {} | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster_id | The ID of the ElastiCache cluster |
| cluster_address | The DNS name of the cache cluster |
| endpoint | The endpoint URL for the Redis cluster |

## Notes

- The cluster ID is automatically generated with a 'redis-' prefix
- Redis version is fixed at 7.0
- Single node configuration (num_cache_nodes = 1)
- Default Redis port (6379) is used
- Default Redis parameter group (default.redis7.0) is used
- Security groups are optional but recommended for production use

## License

MIT Licensed. See LICENSE for full details.