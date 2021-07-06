terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.12.31"
}

provider "aws" {
  region = "eu-west-2"
  profile = "default"
}

module "vpc" {
  source = "./modules/vpc"
  env    = "devops_course"
  az     = "eu-west-2a"
}

module "web_instance" {
  source = "./modules/ec2"
  subnet_id = module.vpc.public_subnet_id
  sg_ids = [module.vpc.public_sg.id]
  name = "web"
  env = "devops_course"
  key_name = "devops-course"
}

output "public_ip" {
  value = module.web_instance.elastic_ip
}
