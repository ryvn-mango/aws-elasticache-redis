# Required variables

variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the Redis cluster will be created"
  type        = string
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks that can access the Redis cluster"
  type        = list(string)
}

variable "subnet_ids" {
  description = "List of VPC Subnet IDs for the cache subnet group"
  type        = list(string)
}

# Optional variables with defaults

variable "node_type" {
  description = "The compute and memory capacity of the nodes"
  type        = string
  default     = "cache.r7g.large"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
