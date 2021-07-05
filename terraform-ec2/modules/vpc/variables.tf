variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "public_subnet" {
  default = "10.0.0.0/24"
}

variable "env" {
  default = ""
}

variable "az" {
  default = ""
}