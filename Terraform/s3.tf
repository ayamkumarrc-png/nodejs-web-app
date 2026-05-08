# S3 Bucket storing logs

resource "aws_s3_bucket" "nodejs-web-app-logs" {
  bucket = "ayam-nodejs-web-app-logs-2026"
  acl    = "private"
}

# S3 Bucket storing jenkins user data

resource "aws_s3_bucket" "jenkins-config" {
  bucket = "ayam-jenkins-config-2026"
  acl    = "private"
}

resource "aws_s3_object" "jenkins-config" {
  bucket = aws_s3_bucket.jenkins-config.id

  for_each = fileset("jenkins-config/", "*")

  key = each.value

  source = "jenkins-config/${each.value}"

  etag = filemd5("jenkins-config/${each.value}")
}
