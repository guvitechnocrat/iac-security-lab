terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "random" {}

# Intentional insecure security group (wide open)
resource "aws_security_group" "bad_sg" {
  name        = "bad_sg"
  description = "Bad SG - wide open"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]   # <-- insecure
  }
}

# Intentional public S3 (and no encryption)
resource "aws_s3_bucket" "public_bucket" {
  bucket = "my-public-bucket-example"   # example only
  acl    = "public-read"                # <-- insecure
}

# Simulated usage of a DB password via variable (we will later inject via Vault)
resource "random_password" "db" {
  length  = 16
  special = true
}
