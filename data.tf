# Get current region
data "aws_region" "current" {}

# Get current Account ID
data "aws_caller_identity" "current" {}
