# Set the AWS provider region to us-east-1
provider "aws" {
  region = "us-east-1"
}

# Define an AWS S3 bucket resource named "example"
resource "aws_s3_bucket" "example" {
  bucket = "checkov-example-bucket-29"
  
  # Configure the S3 bucket as a static website
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

# Define a bucket policy for the S3 bucket
resource "aws_s3_bucket_policy" "example" {
  # Reference the S3 bucket created above by its ID
  bucket = aws_s3_bucket.example.id

  # Define the policy as a JSON string
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "${aws_s3_bucket.example.arn}/*"
    }
  ]
}
POLICY
}

# Define an output named "bucket_name" with the value of the S3 bucket ID
output "bucket_name" {
  value = aws_s3_bucket.example.id
}