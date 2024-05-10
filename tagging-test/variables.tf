variable "instance_tags" {
  description = "Tags for the EC2 instance"
  type        = map(string)
}

variable "aws_account_id" {
  description = "The AWS Account ID"
  type        = string
  default     = "123456789012"  // Replace this with your actual AWS account ID
}

