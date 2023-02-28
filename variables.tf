variable "aws_profile" {
  default = "default"
}

variable "instance_type" {
  description = "Name of the project"
  type        = string
  default     = "t2.micro"
}
variable "region" {
  default = "ap-northeast-1"
}

variable "key_name" {
  description = "Desired name of AWS key pair"
}

variable "public_key_path" {
  description = <<DESCRIPTION
Path to the SSH public key to be used for authentication.
Ensure this keypair is added to your local SSH agent so provisioners can
connect.

Example: ~/.ssh/terraform.pub
DESCRIPTION
}
