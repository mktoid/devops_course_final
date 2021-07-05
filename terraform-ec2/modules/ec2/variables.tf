variable "subnet_id" {
  default = ""
}

variable "root_disc_size" {
  default = 8
}

variable "instance_type" {
  default = "t2.micro"
}

variable "sg_ids" {
  type = list(string)
}

variable "name" {
  default = ""
}

variable "env" {
  default = ""
}

variable "key_name" {
  default = ""
}