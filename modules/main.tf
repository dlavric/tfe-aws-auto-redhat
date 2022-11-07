resource "aws_s3_bucket" "daniela-software" {
  bucket        = "daniela-software"
  force_destroy = true

  tags = {
    Name = "daniela-software"
  }
}

resource "aws_s3_object" "object_license" {
  bucket = "daniela-software"
  key    = "license.rli"
  source = "license.rli"

  depends_on = [
    aws_s3_bucket.daniela-software
  ]

}