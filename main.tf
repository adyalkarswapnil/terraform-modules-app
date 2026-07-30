#dev-infrastructure
module "dev-infra" {
  source = "./infra-app"

  env            = "dev"
  bucket_name    = "infra-app-bucket"
  instance_count = 1
  instance_type  = "t3.micro"
  ec2_ami_id     = "ami-00d2dbb426772b03a" # Example AMI ID for Amazon Linux 2
  hash_key       = "studentId"
}