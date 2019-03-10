variable "region" {
  default = "ap-northeast-1"
}

variable "project" {}

variable "vpc_id" {}

variable "subnet_ids" {
  type = "list"
}

variable "security_group_ids" {
  type = "list"
}

variable "acm_arn" {}
