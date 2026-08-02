data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "remote_s3" {
  bucket = "${var.env}-${var.bucket_name}-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name        = "${var.env}-${var.bucket_name}-${data.aws_caller_identity.current.account_id}"
    Environment = var.env
  }
}