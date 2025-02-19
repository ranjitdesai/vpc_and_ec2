# Define an alias provider for us-east-1
provider "aws" {
  alias  = "useast1"
  region = "us-east-1"
}

# Create an S3 bucket in ap-south-1 (default provider)
resource "aws_s3_bucket" "bucket_ap_south" {
  bucket = "bucket-ap-south"
}

# Create an S3 bucket in us-east-1 (using the alias provider)
resource "aws_s3_bucket" "bucket_us_east" {
  provider = aws.useast1
  bucket   = "bucket-us-east"
}
