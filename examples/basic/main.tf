provider "aws" {
  region = "us-west-2"
}

module "redis" {
  source = "../../"

  region     = "us-west-2"
  node_type  = "cache.t3.micro"
  subnet_ids = ["subnet-12345678", "subnet-87654321"]  # Replace with actual subnet IDs
  
  # Optional: Security groups
  # security_group_ids = ["sg-12345678"]  # Uncomment and replace with actual security group ID if needed
  
  tags = {
    Environment = "dev"
    Project     = "example"
  }
}