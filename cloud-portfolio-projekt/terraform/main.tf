resource "aws_s3_bucket" "bilder_bucket" {
  bucket = "mein-cloud-portfolio-bilder-12345"
}

resource "aws_s3_bucket_public_access_block" "bilder_bucket_access" {
  bucket = aws_s3_bucket.bilder_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_instance" "web_server" {
  ami           = "ami-0669b163befffbdfc"
  instance_type = var.instance_type
  key_name      = "terraform-admin"

  tags = {
    Name = "${var.project_name}-server"
  }
}
