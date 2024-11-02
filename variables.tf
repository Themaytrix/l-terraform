variable "region" {
  type    = string
  default = "us-east-1"
}
variable "image_id" {
  type    = string
  default = "ami-0ddc798b3f1a5117e"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "subnet_id" {
  type    = string
  default = "subnet-093ed15ac807a8952"
}

variable "vpc_security_group_ids" {
  type    = list(string)
  default = ["sg-0f80038d4154d8768","blah"]
}


variable "key_name" {
  type    = string
  default = "first_ec2_key"
}
