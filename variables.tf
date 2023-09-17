variable "bucket_name" {
  description = "The name of the S3 bucket."
  type        = string
}

variable "role_arn" {
  description = "The ARN of the IAM role for backup uploads."
  type        = string
}
