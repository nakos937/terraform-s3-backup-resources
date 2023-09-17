provider "aws" {
  region = "us-east-1"
  # Add other provider configurations as needed
}
resource "aws_s3_bucket" "backup_bucket" {
  bucket = var.bucket_name

  versioning {
    enabled = true
  }

  lifecycle_configuration {
    rule {
      id      = "transition-to-ia"
      status  = "Enabled"
      transition {
        days          = 30
        storage_class = "STANDARD_IA"
      }
    }

    rule {
      id      = "transition-to-glacier"
      status  = "Enabled"
      transition {
        days          = 60
        storage_class = "GLACIER"
      }
    }

    rule {
      id      = "expire-objects"
      status  = "Enabled"
      expiration {
        days = 180
      }
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  logging {
    target_bucket = "your-logging-bucket"
    target_prefix = "logs/"
  }
}

resource "aws_iam_policy" "backup_policy" {
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "BackupPolicy",
        Effect    = "Allow",
        Action    = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Resource  = [
          aws_s3_bucket.backup_bucket.arn,
          "${aws_s3_bucket.backup_bucket.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "backup_policy_attachment" {
  policy_arn = aws_iam_policy.backup_policy.arn
  role       = "arn:aws:iam::123456789012:role/backup_uploader" # Replace with actual role ARN
}
