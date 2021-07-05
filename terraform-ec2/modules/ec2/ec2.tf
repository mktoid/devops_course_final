data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.example.public_key_openssh
}

resource "local_file" "key" {
  content  = tls_private_key.example.private_key_pem
  filename = "id_rsa"
  provisioner "local-exec" {
    command = "chmod 400 id_rsa"
  }
}

resource "aws_instance" "ec2" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  vpc_security_group_ids = var.sg_ids
  key_name = aws_key_pair.generated_key.key_name

  root_block_device {
    volume_size = var.root_disc_size
  }

  tags = {
    Name = var.name
  }
}

resource "aws_eip" "eip" {
  vpc = true
  instance = aws_instance.ec2.id

  tags = {
    Name = "${var.env}_eip"
    Env = var.env
  }
}