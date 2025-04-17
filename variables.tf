variable "region" {
  description = "AWS region"
  type        = string
}

variable "node_type" {
  description = "The compute and memory capacity of the nodes"
  type        = string
  default     = "cache.t3.micro"
}

variable "subnet_group_name" {
  description = "Name for the cache subnet group (if not creating one)"
  type        = string
  default     = null
}

variable "create_subnet_group" {
  description = "Whether to create a subnet group"
  type        = bool
  default     = true
}

variable "subnet_ids" {
  description = "List of VPC Subnet IDs for the cache subnet group"
  type        = list(string)
  default     = []
}

variable "security_group_ids" {
  description = "List of VPC security group IDs"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}