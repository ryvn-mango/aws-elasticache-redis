# AWS ElastiCache Redis Terraform Module

This Terraform module provisions a Redis cluster on Amazon ElastiCache with configurable settings and security groups.

## Features

- Creates a Redis ElastiCache cluster with customizable configuration
- Sets up a dedicated VPC security group with configurable access rules
- Configures subnet groups for the Redis cluster
- Uses Redis 7.1 with optimized settings
- Generates random pet names for resource identification

## Usage

```hcl
module "redis" {
  source = "github.com/ryvn-technologies/aws-elasticache-redis"

  # Required variables
  region     = "us-west-2"
  vpc_id     = "vpc-xxxxxxxx"
  subnet_ids = ["subnet-xxxxxxxx", "subnet-yyyyyyyy"]
  
  # Configure access rules
  allowed_cidr_blocks = ["10.0.0.0/16"]  # Restrict access to VPC CIDR
  
  # Optional configuration
  node_type = "cache.r7g.large"
  
  tags = {
    Environment = "production"
    Project     = "myapp"
  }
}
```

## Requirements

- Terraform >= 1.0.0
- AWS Provider >= 4.0.0
- Random Provider >= 3.0.0

## Providers

| Name   | Version |
|--------|---------|
| aws    | >= 4.0.0 |
| random | >= 3.0.0 |

## Inputs

### Required Variables

| Name | Description | Type | Default |
|------|-------------|------|---------|
| region | AWS region | `string` | - |
| vpc_id | VPC ID where the Redis cluster will be created | `string` | - |
| allowed_cidr_blocks | List of CIDR blocks that can access the Redis cluster | `list(string)` | - |
| subnet_ids | List of VPC Subnet IDs for the cache subnet group | `list(string)` | - |

### Optional Variables

| Name | Description | Type | Default |
|------|-------------|------|---------|
| node_type | The compute and memory capacity of the nodes | `string` | `"cache.r7g.large"` |
| tags | A map of tags to add to all resources | `map(string)` | `{}` |

## Outputs

| Name | Description |
|------|-------------|
| cluster_id | The ID of the ElastiCache cluster |
| cluster_address | The DNS name of the cache cluster |
| endpoint | The endpoint URL for the Redis cluster |
| security_group_id | The ID of the security group created for Redis |
| subnet_group_name | The name of the cache subnet group |

## Security Considerations

- By default, the security group only allows inbound access on port 6379 from the specified CIDR blocks. It's strongly recommended to restrict this to your VPC CIDR or specific application subnets in production environments.
- The module uses a single-node configuration for simplicity and cost-effectiveness.
- Redis AUTH is not enabled by default. Consider enabling it for production deployments.
- The module uses the default Redis 7.1 parameter group which includes recommended security settings.

## Technical Details

- Redis version 7.1 is used by default
- Uses the default Redis 7.1 parameter group
- Single node configuration (non-clustered mode)
- Default Redis port (6379) is used
- Automatic backup is not enabled (in-memory cache)
- Maintenance window uses AWS default scheduling
- Cluster ID is automatically generated with a 'redis-' prefix

## License

This module is maintained by Ryvn Technologies.