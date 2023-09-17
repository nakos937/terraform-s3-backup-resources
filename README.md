# terraform-s3-backup-resources
Terraform module for setting up an S3 bucket optimized for backup storage. Implements best practices including versioning, lifecycle policies, server-side encryption, and access control for uploads. Enables automatic transitioning to cost-effective storage classes and expiring objects after 180 days.

## Features:

   - Versioning for object history and recovery.
   - Lifecycle policies for cost-effective storage management.
   - Server-side encryption for data security at rest.
   - IAM role-based access control for backup uploads.

## Usage:
   In this configuration, you'll need to replace placeholders like your-logging-bucket, and arn:aws:iam::123456789012:role/backup_uploader with your actual values.
   Remember to replace region, bucket_name, and role_arn in variables.tf with appropriate values.
   1.  Clone the repository.
   2.  Customize variables and backend configurations in variables.tf and backend.tf.
   3.  Run terraform init, terraform plan, and terraform apply to deploy the S3 bucket.
