resource "aws_s3_bucket" "group_s3" {
  bucket = "fatimasang1"  
  acl    = "private"  
}

resource "aws_dynamodb_table" "terraform_lock" {
  name           = "terraform-lock-table" # Replace with your desired table name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock-table"
  }
}
