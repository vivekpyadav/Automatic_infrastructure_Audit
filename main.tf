provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "insecure_bucket" {
  bucket = "grc-audit-test-bucket-2026-vivek" # Keep this unique
}

# Fix CKV_AWS_21: Enable Versioning
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.insecure_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Fix CKV_AWS_145: Enable Encryption (KMS)
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.insecure_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Fix CKV_AWS_53, 54, 55, 56: Block Public Access
resource "aws_s3_bucket_public_access_block" "public_block" {
  bucket = aws_s3_bucket.insecure_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
