data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_subnets" "private_subnet_ids" {
    filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    Name = "*private*"
  }
}

data "aws_subnets" "public_subnet_ids" {
    filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    Name = "*public*"
  }
}

data "aws_subnet" "public_subnet" {
  for_each = toset(data.aws_subnets.public_subnet_ids.ids)
  id       = each.value
}

data "aws_subnet" "private_subnet" {
  for_each = toset(data.aws_subnets.private_subnet_ids.ids)
  id       = each.value
}
