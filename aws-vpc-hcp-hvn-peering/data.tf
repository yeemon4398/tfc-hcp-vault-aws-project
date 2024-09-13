data "hcp_hvn" "hcp_vault" {
  hvn_id = var.hvn_id
}

data "vault_aws_access_credentials" "master_netadmin_creds" {
  backend = var.backend_path
  role    = var.backend_role
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

data "aws_route_table" "private_route_table" {
  subnet_id = data.aws_subnets.private_subnet_ids.ids[0]
}

## db 
data "aws_subnets" "db_subnet_ids" {
    filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    Name = "*db*"
  }
}

data "aws_route_table" "db_route_table" {
  subnet_id = data.aws_subnets.db_subnet_ids.ids[0]
}

data "aws_arn" "vpc_region" {
  arn = data.aws_vpc.selected.arn
}