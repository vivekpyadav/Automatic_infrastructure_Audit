provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "insecure_bucket" {
  bucket = "my-very-insecure-grc-test-bucket"
  # GRC RISK: No encryption defined
  # GRC RISK: No versioning defined
}

resource "aws_s3_bucket_public_access_block" "bad_idea" {
  bucket = aws_s3_bucket.insecure_bucket.id

  # GRC RISK: Setting these to false allows public access!
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
