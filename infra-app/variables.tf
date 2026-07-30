variable "env" {
    description = "this is the environment for my infra"
    type = string
}

variable "bucket_name" {
    description = "this in the bucket name for my infra"
    type = string
}

variable "instance_count" {
    description = "this is the number of ec2 instance for my infra"
    type = number
}

variable "instance_type" {
    description = "this is the instance type for for my infra"
    type = string
}

variable "ec2_ami_id" {
    description ="this is the ami id for my infra"
    type = string
}

variable "hash_key" {
    description = "this is hash key for my dynamodb infra"
    type = string
}